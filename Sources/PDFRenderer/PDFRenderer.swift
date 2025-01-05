import Foundation
import SwiftUI

@MainActor
public enum PDFRenderer {
    struct CGError: Error {
        let message: String
    }

    /// Renders the supplied view(s) to a PDF, one view per page, at
    /// the specified size (in mm), storing the result
    /// at the given URL
    /// - Parameters:
    ///   - views: The view(s) to render
    ///   - size: The dimensions, in mm, of the page to render to
    ///   - url: The location to store the result at
    public static func render(_ views: [some View], size: CGSize, to url: URL) throws {
        // We've been told the real-world dimensions, but CoreGraphics works in PostScript points
        // (1/72nd of an inch) so we first scale the target size to match that...
        let frameSize = size.postscriptSize()

        // ... then we tell our views to fit in that size
        let framedViews = views.map {
            $0.frame(width: frameSize.width, height: frameSize.height)
        }

        // ... and tell the context to render to a region of that size
        var bounds = CGRect(origin: .zero, size: frameSize)

        guard let pdf = CGContext(url as CFURL, mediaBox: &bounds, nil) else {
            throw CGError(message: "Couldn't create PDF context")
        }

        // Render the views, one to a page
        for view in framedViews {
            let renderer = ImageRenderer(content: view)

            renderer.render { size, context in
                pdf.beginPDFPage(nil)

                // Render the SwiftUI view data onto the page
                context(pdf)

                pdf.endPDFPage()
            }
        }

        pdf.closePDF()
    }
}

public extension Array where Element: View {
    /// Convenience to allow rendering an array of views
    /// - Parameters:
    ///   - size: The desired size (in mm) of the output
    ///   - url: The URL to write the output to
    @MainActor
    func render(size: CGSize, to url: URL) throws {
        try PDFRenderer.render(self, size: size, to: url)
    }
}

public extension View {
    /// Convenience to allow rendering a single view
    /// - Parameters:
    ///   - size: The desired size (in mm) of the output
    ///   - url: The URL to write the output to
    @MainActor
    func render(size: CGSize, to url: URL) throws {
        try [self].render(size: size, to: url)
    }
}
