// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ServiceImplementation",
    platforms: [ .iOS(.v16), .macOS(.v13) ],
    products: [
        .library(name: "FightingServiceImplementation", targets: ["FightingServiceImplementation"]),
    ],
    dependencies: [
        .package(path: "../Services"),
    ],
    targets: [
        .target(
            name: "FightingServiceImplementation",
            dependencies: [ .product(name: "FightingServices", package: "Services") ],
            path: "FightingServiceImplementation"
        ),
    ]
)
