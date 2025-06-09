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

extension AuthService {
    func login(username: String, password: String) async throws -> (token: String, userId: Int) {
        let url = URL(string: "\(baseURL)/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["username": username, "password": password]
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(LoginResponse.self, from: data)
        let token = response.token
        let userId = try await getUserId(by: username)
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(userId, forKey: "userId")
        return (token, userId)
    }

    func getUserId(by username: String) async throws -> Int {
        let url = URL(string: "\(baseURL)/users")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode([User].self, from: data)
        if let user = users.first(where: { $0.username == username }) {
            return user.id
        } else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
    }

    func getUserId() -> Int? {
        let userId = UserDefaults.standard.integer(forKey: "userId")
        return userId != 0 ? userId : nil
    }
}
