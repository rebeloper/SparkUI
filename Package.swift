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
        .package(url: "https://github.com/ruslanskorb/RSKPlaceholderTextView.git", .upToNextMajor(from: "6.0.2")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/HeroTransitions/Hero.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/huri000/SwiftEntryKit.git", .upToNextMajor(from: "1.2.3")),
        .package(url: "https://github.com/Nirma/UIFontComplete.git", .upToNextMajor(from: "4.0.1")),
        .package(url: "https://github.com/artman/Signals.git", .upToNextMajor(from: "6.1.0")),
        .package(url: "https://github.com/marksands/BetterCodable.git", .upToNextMajor(from: "0.1.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SparkUI",
            dependencies: [
                "Layoutless",
                "RSKPlaceholderTextView",
                "Kingfisher",
                "Hero",
                "SwiftEntryKit",
                "UIFontComplete",
                "Signals",
                "BetterCodable"
        ]),
        .testTarget(
            name: "SparkUITests",
            dependencies: ["SparkUI"]),
    ]
)
