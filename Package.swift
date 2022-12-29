// swift-tools-version:4.0
import PackageDescription

let package = Package(
	name: "SCNViewController",
	products: [
		.library(name: "SCNViewController", targets: [ "SCNViewController" ]),
	],
	dependencies: [],
	targets: [
		.target(name: "SCNViewController", dependencies: [], path: "Sources/"),
		.testTarget(name: "SCNViewControllerTests", dependencies: ["SCNViewController"], path: "Tests/"),
	],
	swiftLanguageVersions: [
		3,
		4,
		5,
	]
)
