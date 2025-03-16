// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWJavaScriptContext_Thumbnail",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "WWJavaScriptContext_Thumbnail", targets: ["WWJavaScriptContext_Thumbnail"]),
    ],
    dependencies: [
        .package(url: "https://github.com/William-Weng/WWJavaScriptContext", from: "1.1.0"),
        .package(url: "https://github.com/William-Weng/WWNetworking", from: "1.7.5")
    ],
    targets: [
        .target(name: "WWJavaScriptContext_Thumbnail", dependencies: ["WWJavaScriptContext", "WWNetworking"], resources: [.process("Script"), .copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
