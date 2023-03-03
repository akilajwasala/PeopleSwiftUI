//
//  NetworkingManagerCreateFailureMock.swift
//  People
//
//  Created by J on 2023-03-02.
//

#if DEBUG
import Foundation

class NetworkingManagerCreateFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
}
#endif
