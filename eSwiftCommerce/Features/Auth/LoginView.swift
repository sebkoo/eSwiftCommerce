//
//  LoginView.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        Form {
            TextField("User Name", text: $viewModel.username)
            SecureField("Password", text: $viewModel.password)
            Button("Login") {
                Task {
                    await viewModel.login()
                    if viewModel.isLoggedIn {
                        appState.isLoggedIn = true
                    }
                }
            }
            .disabled(viewModel.isLoading)
        }
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil)) {
            Button("OK") { viewModel.error = nil }
        } message: {
            Text(viewModel.error?.localizedDescription ?? "Unknown error")
        }
        .navigationTitle("Login")
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}
