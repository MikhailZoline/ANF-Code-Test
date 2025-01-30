// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let targetDependency: Target.Dependency = .product(name: "Models", package: "Models")

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
        .package(name: "Models", path: "../Models")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                targetDependency
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"],
            resources: [
                .copy("Resources/exploreData.json"),
            ]
        ),
    ]
)
