//
//  Models.swift
//  People
//
//  Created by J on 2023-02-16.
//

// Mark: - User
struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// Mark: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}
