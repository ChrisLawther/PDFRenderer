import Foundation

private extension CGSize {
    func rotated() -> CGSize {
        CGSize(width: height, height: width)
    }
}

public enum PageSize {
    public enum A6 {
        public static var landscape: CGSize { CGSize(width: 148.5, height: 105) }
        public static var portrait: CGSize { landscape.rotated() }
    }

    public enum A5 {
        public static var landscape: CGSize { CGSize(width: 210, height: 148.5) }
        public static var portrait: CGSize { landscape.rotated() }
    }

    public enum A4 {
        public static var landscape: CGSize { CGSize(width: 297, height: 210) }
        public static var portrait: CGSize { landscape.rotated() }
    }

    public enum A3 {
        public static var landscape: CGSize { CGSize(width: 420, height: 297) }
        public static var portrait: CGSize { landscape.rotated() }
    }

    public enum A2 {
        public static var landscape: CGSize { CGSize(width: 594, height: 420) }
        public static var portrait: CGSize { landscape.rotated() }
    }

    public enum A1 {
        public static var landscape: CGSize { CGSize(width: 841, height: 594) }
        public static var portrait: CGSize { landscape.rotated() }
    }

    public enum A0 {
        public static var landscape: CGSize { CGSize(width: 1189, height: 841) }
        public static var portrait: CGSize { landscape.rotated() }
    }
}

public extension CGSize {
    func postscriptSize() -> CGSize {
        let mmFactor = 72.0 / 25.4

        return CGSize(width: width * mmFactor,
                      height: height * mmFactor)
    }
}
