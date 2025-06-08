//
//  LoginViewModel.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    @Published var error: Error?

    private let authService = AuthService.shared

    func login() async {
        isLoading = true
        do {
            _ = try await authService.login(username: username, password: password)
            isLoggedIn = true
        } catch {
            self.error = error
        }
        isLoggedIn = false
    }
}
