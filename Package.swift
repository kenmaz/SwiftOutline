// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftOutline",
    products: [
        .executable(name: "SwiftOutline", targets: ["SwiftOutline"]),
        .library(name: "SwiftOutlineKit", type: .static, targets: ["SwiftOutlineKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0")),
        .package(url: "https://github.com/kylef/PathKit", from: "1.0.0"),
        .package(url: "https://github.com/kylef/Commander.git", from: "0.9.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftOutline",
            dependencies: [
                "SwiftOutlineKit",
                "Commander",
            ]),
        .target(
            name: "SwiftOutlineKit",
            dependencies: [
                "SwiftSyntax",
                "PathKit",
            ]),
        .testTarget(
            name: "SwiftOutlineTests",
            dependencies: ["SwiftOutline"]),
        .testTarget(
            name: "SwiftOutlineKitTests",
            dependencies: [
                "SwiftOutlineKit",
            ]),
    ]
)
