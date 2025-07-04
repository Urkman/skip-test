// swift-tools-version: 6.0
// This is a Skip (https://skip.tools) package.
import PackageDescription

let package = Package(
    name: "skip-test",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14), .tvOS(.v17), .watchOS(.v10), .macCatalyst(.v17)],
    products: [
        .library(name: "SktipTest", type: .dynamic, targets: ["SktipTest"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.5.18"),
        .package(url: "https://source.skip.tools/skip-fuse-ui.git", "0.0.0"..<"2.0.0")
    ],
    targets: [
        .target(name: "SktipTest", dependencies: [
            .product(name: "SkipFuseUI", package: "skip-fuse-ui")
        ], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
