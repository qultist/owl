//
//  PackageResourceView.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 12.07.21.
//

import SwiftUI

struct PackageResourceView: View {

	@ObservedObject var viewModel: PackageResourceViewModel

    var body: some View {
		ScrollableText(text: viewModel.text)
			.navigationBarTitle(viewModel.title, displayMode: .inline)
    }
}
