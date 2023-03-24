// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProjectDependencies",
    platforms: [ .iOS(.v16), .macOS(.v13) ],
    products: [
        .library(
            name: "ProjectDependencies",
            targets: ["ProjectDependencies"]
        ),
    ],
    dependencies: [
        .package(path: "../Services"),
        .package(path: "../ServiceImplementation")
    ],
    targets: [
        .target(
            name: "ProjectDependencies",
            dependencies: [
                .product(name: "FightingServices", package: "Services"),
                .product(name: "FightingServiceImplementation", package: "ServiceImplementation")
            ],
            path: "ProjectDependencies"
        ),
    ]
)
