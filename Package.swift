// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWJavaScriptContext+Thumbnail",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(name: "WWJavaScriptContext+Thumbnail", targets: ["WWJavaScriptContext+Thumbnail"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWJavaScriptContext", from: "1.0.3"),
        .package(url: "https://github.com/William-Weng/WWNetworking", from: "1.6.2")
    ],
    targets: [
        .target(name: "WWJavaScriptContext+Thumbnail", dependencies: ["WWJavaScriptContext", "WWNetworking"], resources: [.process("Script"), .copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
