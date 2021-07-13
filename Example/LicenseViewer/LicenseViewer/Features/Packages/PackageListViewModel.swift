//
//  PackageListViewModel.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 11.07.21.
//

import Foundation

final class PackageListViewModel: ObservableObject {

	@Published var packages: [SwiftPackage]

	private unowned let coordinator: Coordinator

	init(coordinator: Coordinator) {
		self.coordinator = coordinator

		let packagesJsonUrl = Bundle.main.url(forResource: "packages", withExtension: "json", subdirectory: "Licenses")!
		let packagesJsonData = try! Data(contentsOf: packagesJsonUrl)
		packages = try! JSONDecoder().decode([SwiftPackage].self, from: packagesJsonData)
	}

	func open(_ resource: String, fromPackage packageName: String) {
		coordinator.open(resource, fromPackage: packageName)
	}

	func showFileSelection(forPackage package: SwiftPackage) {
		coordinator.showFileSelection(forPackage: package)
	}
}
