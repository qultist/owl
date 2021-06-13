import Foundation

struct WorkspaceState: Codable {

	let object: Object
}

struct Object: Codable {

	let dependencies: [Dependency]
}

struct Dependency: Codable {

	let packageRef: PackageRef
	let state: State
	let subpath: String
}

struct PackageRef: Codable {

	let identity: String
	let name: String
	let path: String
}

struct State: Codable {

	let checkoutState: CheckoutState
}

struct CheckoutState: Codable {

	let version: String
}
