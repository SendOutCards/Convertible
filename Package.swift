// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Convertible",
    products: [
        .library(name: "Convertible", targets: ["Convertible"]),
    ],
    targets: [
        .target(name: "Convertible"),
        .testTarget(name: "ConvertibleTests", dependencies: ["Convertible"]),
    ]
)
