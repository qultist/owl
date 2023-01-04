// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Owl",
	products: [
		.plugin(name: "OwlPlugin", targets: ["OwlPlugin"])
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
	],
	targets: [
		.executableTarget(
			name: "Owl",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser")
			]
		),
		.plugin(name: "OwlPlugin", capability: .buildTool(), dependencies: ["Owl"])
	]
)
