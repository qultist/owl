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

	/// Path of the package. Available up to and including Xcode 12.5.1 and is replaced by ``location``.
	let path: String?

	/// Location of the package. Available since Xcode 13 and replaces ``path``.
	let location: String?
}

struct State: Codable {

	let checkoutState: CheckoutState
}

struct CheckoutState: Codable {

	let branch: String?
	let version: String?
	let revision: String
}
