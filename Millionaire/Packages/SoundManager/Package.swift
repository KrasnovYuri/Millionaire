// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SoundManager",
    products: [
        .library(
            name: "SoundManager",
            targets: ["SoundManager"]),
    ],
    targets: [
        .target(
            name: "SoundManager",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "SoundManagerTests",
            dependencies: ["SoundManager"]
        ),
    ]
)
