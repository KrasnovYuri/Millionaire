// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Questions",
    products: [
        .library(
            name: "Questions",
            targets: ["Questions"]),
    ],
    targets: [
        .target(
            name: "Questions",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "QuestionsTests",
            dependencies: ["Questions"]),
    ]
)
