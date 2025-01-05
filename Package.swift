// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PDFRenderer",
    platforms: [
        .macOS(.v15),   // For *many* things
        .iOS(.v16)      // For `ImageRenderer`
    ],
    products: [
        .library(
            name: "PDFRenderer",
            targets: ["PDFRenderer"]),
    ],
    targets: [
        .target(
            name: "PDFRenderer"),
        .testTarget(
            name: "PDFRendererTests",
            dependencies: ["PDFRenderer"]
        ),
    ]
)
