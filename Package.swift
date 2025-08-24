// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomAlert",
    platforms: [
        .iOS(.v15),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "CustomAlert",
            targets: ["CustomAlert"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/divadretlaw/WindowKit", from: "2.5.2")
    ],
    targets: [
        .target(
            name: "CustomAlert",
            dependencies: ["WindowKit"],
            swiftSettings: [
                // .define("CUSTOM_ALERT_DESIGN")
            ]
        )
    ]
)
