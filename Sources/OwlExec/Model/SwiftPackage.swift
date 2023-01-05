import Foundation

final class SwiftPackage: Codable {

	let name: String
	let version: String
	var licenseFile: String?
	var noticeFile: String?

	init(from dependency: Dependency) {
		name = dependency.packageRef.name

		let checkoutState = dependency.state.checkoutState
		version = checkoutState.version ?? checkoutState.branch ?? String(checkoutState.revision.prefix(7))
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(version, forKey: .version)
		try container.encode(licenseFile, forKey: .licenseFile)
		try container.encode(noticeFile, forKey: .noticeFile)
	}
}
