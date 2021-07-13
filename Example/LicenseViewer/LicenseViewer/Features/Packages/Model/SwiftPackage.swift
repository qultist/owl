//
//  SwiftPackage.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 25.06.21.
//

import Foundation

struct SwiftPackage: Codable {

	let name: String
	let version: String
	let licenseFile: String?
	let noticeFile: String?
}

extension SwiftPackage: Identifiable {

	var id: String { name }
}

extension SwiftPackage {

	var hasLicenseAndNoticeFile: Bool { licenseFile != nil && noticeFile != nil }
}
