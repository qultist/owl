//
//  CoordinatorView.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 11.07.21.
//

import SwiftUI

struct CoordinatorView: View {

	@ObservedObject var coordinator: Coordinator

	var body: some View {
		NavigationView {
			PackageListView(viewModel: coordinator.packageListViewModel)
				.navigation(item: $coordinator.packageResourceViewModel) { PackageResourceView(viewModel: $0) }
				.actionSheet(item: $coordinator.selectedPackage) { package in
					ActionSheet(title: Text("File"), buttons: [
						.default(Text("License")) {
							coordinator.open(package.licenseFile!, fromPackage: package.name)
						},
						.default(Text("Notice")) {
							coordinator.open(package.noticeFile!, fromPackage: package.name)
						},
						.cancel()
					])
				}
		}
	}
}
