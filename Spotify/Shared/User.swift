//
//  User.swift
//  Spotify
//
//  Created by Hussien Awada on 28/06/2025.
//

import Foundation

struct UserArray: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let bloodGroup: String
    let height, weight: Double
    
    static var mock: User {
        User(
            id: 444,
            firstName: "Hussein",
            lastName: "Awada",
            age: 20,
            email: "hussein@icloud.com",
            phone: "961783883333333e",
            username: "HUssein",
            password: "blabla",
            birthDate: "1990",
            image: Constants.randomImage,
            bloodGroup: "",
            height: 184,
            weight: 1888
        )
    }
}
