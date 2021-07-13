//
//  Coordinator.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 11.07.21.
//

import Foundation

final class Coordinator: ObservableObject {

	@Published var packageListViewModel: PackageListViewModel!
	@Published var packageResourceViewModel: PackageResourceViewModel?

	@Published var selectedPackage: SwiftPackage?

	init() {
		packageListViewModel = PackageListViewModel(coordinator: self)
	}

	func open(_ resource: String, fromPackage packageName: String) {
		packageResourceViewModel = PackageResourceViewModel(title: packageName, resource: resource, coordinator: self)
	}

	func showFileSelection(forPackage package: SwiftPackage) {
		selectedPackage = package
	}
}
