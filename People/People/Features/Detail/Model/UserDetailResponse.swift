//
//  UserDetailResponse.swift
//  People
//
//  Created by J on 2023-02-22.
//

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable, Equatable {
    let data: User
    let support: Support
}
