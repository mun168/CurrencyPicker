// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CurrencyPicker",
    platforms: [.iOS("15")],
    products: [
            .library(
                name: "CurrencyPicker",
                targets: ["CurrencyPicker"]
            )
        ],
        dependencies: [
        ],
    targets: [
        .target(
            name: "CurrencyPicker",
            dependencies: [],
            resources: [.copy("Resources/currencies.json")]
        ),
        .testTarget(
            name: "CurrencyPickerTests",
            dependencies: ["CurrencyPicker"]
        ),
    ]
)
