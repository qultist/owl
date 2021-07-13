//
//  PackageResourceViewModel.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 11.07.21.
//

import Foundation

final class PackageResourceViewModel: ObservableObject {

	@Published var title: String
	@Published var text: String

	private unowned let coordinator: Coordinator

	init(title: String, resource: String, coordinator: Coordinator) {
		self.title = title
		self.coordinator = coordinator

		if let url = Bundle.main.url(forResource: resource, withExtension: nil, subdirectory: "Licenses"),
		   let contents = try? String(contentsOf: url, encoding: .utf8) {
			text = contents
		} else {
			text = "Resource could not be loaded."
		}
	}
}
