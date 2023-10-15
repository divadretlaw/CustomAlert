// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomAlert",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "CustomAlert",
            targets: ["CustomAlert"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/divadretlaw/WindowKit", branch: "main")
    ],
    targets: [
        .target(name: "CustomAlert", dependencies: ["WindowKit"])
    ]
)
