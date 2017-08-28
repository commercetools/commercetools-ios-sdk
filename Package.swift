// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Commercetools",
    products: [.library(name: "Commercetools", targets: ["Commercetools"])],
    targets: [.target(name: "Commercetools", dependencies: [], path: "Source")]
)
