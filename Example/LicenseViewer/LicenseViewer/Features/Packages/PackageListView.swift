//
//  PackageListView.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 11.07.21.
//

import SwiftUI

struct PackageListView: View {

	@ObservedObject var viewModel: PackageListViewModel

	var body: some View {
		List(viewModel.packages) { package in
			if package.hasLicenseAndNoticeFile {
				Button(action: {
					viewModel.showFileSelection(forPackage: package)
				}) {
					HStack {
						Text(package.name)
							.layoutPriority(1)
						Spacer()
						NavigationLink(destination: EmptyView()) { EmptyView() }
					}
				}
			} else if let license = package.licenseFile {
				Text(package.name)
					.onNavigation { viewModel.open(license, fromPackage: package.name) }
			} else if let notice = package.noticeFile {
				Text(package.name)
					.onNavigation { viewModel.open(notice, fromPackage: package.name) }
			} else {
				Text(package.name)
			}
		}
		.navigationTitle("Packages")
	}
}
