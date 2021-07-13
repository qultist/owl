//
//  LicenseViewerApp.swift
//  LicenseViewer
//
//  Created by Dominic Schmidt on 25.06.21.
//

import SwiftUI

@main
struct LicenseViewerApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: Coordinator())
        }
    }
}
