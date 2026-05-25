// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PhoneNumberKitUI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "PhoneNumberKitUI", targets: ["PhoneNumberKitUI"])
    ],
    dependencies: [
        .package(url: "https://github.com/PhoneNumberKit/PhoneNumberKit", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "PhoneNumberKitUI",
            dependencies: [
                .product(name: "PhoneNumberKit", package: "PhoneNumberKit")
            ],
            path: "Sources/PhoneNumberKitUI"
        ),
        .testTarget(
            name: "PhoneNumberKitUITests",
            dependencies: ["PhoneNumberKitUI"],
            path: "Tests/PhoneNumberKitUITests"
        )
    ]
)
