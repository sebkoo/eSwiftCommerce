//
//  AuthService.swift
//  eSwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/7/25.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    private let baseURL = "https://fakestoreapi.com"
    private let tokenKey = "authToken"

    func login(username: String, password: String) async throws -> String {
        let url = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["username": username, "password": password]
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(LoginResponse.self, from: data)
        UserDefaults.standard.set(response.token, forKey: tokenKey)
        return response.token
    }

    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
}

struct LoginResponse: Codable {
    let token: String
}
