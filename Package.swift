// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "Owl",
	products: [
		.plugin(name: "Owl", targets: ["Owl"])
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
	],
	targets: [
		.executableTarget(
			name: "OwlExec",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser")
			]
		),
		.plugin(name: "Owl", capability: .buildTool(), dependencies: ["OwlExec"])
	]
)
