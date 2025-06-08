//
//  AppState.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false

    init() {
        if AuthService.shared.getToken() != nil {
            isLoggedIn = true
        }
    }
}
