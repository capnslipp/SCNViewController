// swift-tools-version:5.0
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
		.version("3"),
		.version("4"),
		.version("4.2"),
		.version("5"),
	]
)
