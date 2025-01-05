import Foundation

enum PageSize {
    enum A4 {
        static var landscape: CGSize { CGSize(width: 297, height: 210) }
        static var portrait: CGSize { CGSize(width: 210, height: 297) }
    }
}

extension CGSize {
    func postscriptSize() -> CGSize {
        let mmFactor = 72.0 / 25.4

        return CGSize(width: width * mmFactor, height: height * mmFactor)
    }
}
