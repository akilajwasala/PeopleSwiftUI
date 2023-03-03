//
//  StaticJSONMapper.swift
//  People
//
//  Created by J on 2023-02-16.
//

import Foundation

// Mark: - StaticJSONMapper 
struct StaticJSONMapper {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard !file.isEmpty,
                let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path)
        else {
            throw MappingError.failedToGetContents
        }
        
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        return try decorder.decode(T.self, from: data)
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
}
