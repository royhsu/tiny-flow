// swift-tools-version:5.2
import PackageDescription

let package = Package(
  name: "TinyFlow",
  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
  products: [.library(name: "TinyFlow", targets: ["TinyFlow"])],
  targets: [
    .target(name: "TinyFlow"),
    .testTarget(
      name: "TinyFlowTests",
      dependencies: [.target(name: "TinyFlow")]
    ),
  ]
)
