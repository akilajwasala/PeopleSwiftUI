//
//  NetworkingManager.swift
//  People
//
//  Created by J on 2023-02-23.
//

import Foundation

protocol NetworkingManagerImpl {
    func request<T: Codable>(session: URLSession
                             , _ endpoint: Endpoint,
                             type: T.Type) async throws -> T
    
    func request(session: URLSession,
                 _ endpoint: Endpoint) async throws
}

final class NetworkingManager: NetworkingManagerImpl {
    
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(session: URLSession = .shared
                             , _ endpoint: Endpoint,
                             type: T.Type) async throws -> T {
                
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }

        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decorder.decode(T.self, from: data)

        return res
    }
    
    func request(session: URLSession = .shared,
                 _ endpoint: Endpoint) async throws {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (_, response) = try await session.data(for: request)

        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }

    }
}

extension NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
    
}

extension NetworkingManager.NetworkingError {

    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .custom(let error):
            return "Something went wrong \(error.localizedDescription)"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Filed to decode"
        }
    }
}

private extension NetworkingManager {
    func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
    
}
