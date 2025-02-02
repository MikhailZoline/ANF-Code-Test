// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let targetDependencies: [Target.Dependency] = [.product(name: "Models", package: "Models"), .product(name: "Cache", package: "Cache")]

let package = Package(
    name: "Networking",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(name: "Models", path: "../Models"),
        .package(name: "Cache", path: "../Cache")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: targetDependencies,
            resources: [
                .copy("Resources/exploreData.json"),
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]
//            resources: [
//                .copy("Resources/exploreData.json"),
//            ]
        ),
    ]
)
