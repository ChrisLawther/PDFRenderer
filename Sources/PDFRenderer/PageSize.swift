import Foundation

public enum PageSize {
    public enum A4 {
        public static var landscape: CGSize { CGSize(width: 297, height: 210) }
        public static var portrait: CGSize { CGSize(width: 210, height: 297) }
    }
}

public extension CGSize {
    func postscriptSize() -> CGSize {
        let mmFactor = 72.0 / 25.4

        return CGSize(width: width * mmFactor, height: height * mmFactor)
    }
}
