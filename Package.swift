// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SparkUI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "SparkUI",
            targets: ["SparkUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/DeclarativeHub/Layoutless.git", .upToNextMajor(from: "0.4.2")),
        .package(url: "https://github.com/rebeloper/SparkExtensions.git", .upToNextMajor(from: "0.0.28")),
        .package(url: "https://github.com/rebeloper/SparkMisc.git", .upToNextMajor(from: "0.0.3")),
        .package(url: "https://github.com/JonasGessner/JGProgressHUD", .upToNextMajor(from: "2.1.0")),
        .package(url: "https://github.com/DeclarativeHub/ReactiveKit.git", .upToNextMajor(from: "3.10.0")),
        .package(url: "https://github.com/DeclarativeHub/Bond.git", .upToNextMajor(from: "7.4.1")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SparkUI",
            dependencies: [
                "Layoutless",
                "SparkExtensions",
                "SparkMisc",
                "JGProgressHUD",
                "ReactiveKit",
                "Bond"
        ]),
        .testTarget(
            name: "SparkUITests",
            dependencies: ["SparkUI"]),
    ]
)
