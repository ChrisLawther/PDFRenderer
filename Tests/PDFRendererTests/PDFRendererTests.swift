import Testing
import SwiftUI

@testable import PDFRenderer

@Test func makeSinglePageSample() async throws {
    // Creates a single page PDF, in the temporary directory. Not really a *test* as such (no assertions!)
    let view = SampleView(text: "Single page sample")

    let url = URL.temporaryDirectory.appendingPathComponent("single-page sample.pdf")
    try await view.render(size: PageSize.A4.landscape, to: url)
    print("open \"\(url.path(percentEncoded: false))\"")
}

@Test func makeMultiPageSample() async throws {
    // Creates a single page PDF, in the temporary directory. Not really a *test* as such (no assertions!)
    let views = ["First page", "Second page", "Last page"].map { SampleView(text:$0)}

    let url = URL.temporaryDirectory.appendingPathComponent("multi-page sample.pdf")
    try await views.render(size: PageSize.A4.landscape, to: url)
    print("open \"\(url.path(percentEncoded: false))\"")
}

struct SampleView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
    }
}
