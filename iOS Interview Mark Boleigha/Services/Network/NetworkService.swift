//
//  NetworkService.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 16/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import Combine

//protocol NetworkService {
//    func fetch<T: Codable>(_ request: NetworkRequest) ->
//    func fetchList<T: Codable>(_ request: NetworkRequest, completion: @escaping (NetworkResponse, _ data: T?) -> Void)
//    func push<T: Codable>(_ request: NetworkRequest, completion: @escaping (NetworkResponse, _ data: T?) -> Void)
//}

enum NetworkResponse {
    case success
    case failed(NetworkError)
    
    var localizedDescription: String {
        switch self {
        case .success:
            return "successful"
        case .failed(let error):
            return error.localizedDescription
        }
    }
}

enum NetworkError: Error {
    case api_error(String)
    case unauthenticated
    case unauthorized
    case not_found
    case unknown(String)
    
    var localizedDescription: String {
        switch self {
        case .api_error(let error):
            return error
        case .unauthenticated, .unauthorized:
            return "Request authorization failed, please login"
        case .not_found:
            return "Requested URL was not found"
        case .unknown(let error):
            return error
        }
    }
}

extension NetworkError: Comparable {
    static func < (lhs: NetworkError, rhs: NetworkError) -> Bool {
        return false
    }
    
    static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
        return lhs.localizedDescription == rhs.localizedDescription
    }
}
