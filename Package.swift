// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Commercetools",
    products: [.library(name: "Commercetools", targets: ["Commercetools"])],
    targets: [.target(name: "Commercetools", dependencies: [], path: "Source")]
)
