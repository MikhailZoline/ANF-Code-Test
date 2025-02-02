// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let targetDependencies: [Target.Dependency] = [
    .product(name: "Models", package: "Models")
]
                                               
let package = Package(
    name: "Cache",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Cache",
            targets: ["Cache"]),
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
    ],
    targets: [
        .target(
            name: "Cache",
            dependencies: targetDependencies
        ),
        .testTarget(
            name: "CacheTests",
            dependencies: ["Cache"]
        ),
    ]
)
