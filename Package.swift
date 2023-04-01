// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomAlert",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CustomAlert",
            targets: ["CustomAlert"]),
    ],
    dependencies: [
        .package(url: "https://github.com/divadretlaw/WindowSceneReader", from: "1.1.0")
    ],
    targets: [
        .target(name: "CustomAlert", dependencies: ["WindowSceneReader"])
    ]
)
