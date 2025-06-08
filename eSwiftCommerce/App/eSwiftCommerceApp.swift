//
//  eSwiftCommerceApp.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import SwiftUI

@main
struct eSwiftCommerceApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.isLoggedIn {

            } else {
                LoginView()
                    .environmentObject(appState)
            }
        }
    }
}
