//
//  UsersResponse.swift
//  People
//
//  Created by J on 2023-02-16.
//

// Mark: - UsersResponse
struct UsersResponse: Codable, Equatable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
