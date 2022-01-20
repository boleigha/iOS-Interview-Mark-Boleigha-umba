//
//  NetworkService.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 16/01/2022.
//

import Foundation
import Combine
import Alamofire

protocol NetworkService {
    func request<T: Codable>(_ request: NetworkRequest, completion: @escaping (NetworkResponse, _ data: T?) -> Void)
    func buildRequestHeaders(encoding: RequestEncoding, apiKey: String?) -> HTTPHeaders
}

struct NetworkRequest {
    var endpoint: API
    var method: HTTPMethod
    var encoding: RequestEncoding
    var body: Dictionary<String, Any>
    var files: Dictionary<String, Data> = [:]
    
    init(endpoint: API, method: HTTPMethod,encoding: RequestEncoding? = .urlJson, body: Dictionary<String, Any>) {
        self.endpoint = endpoint
        self.method = method
        self.body = body
        self.encoding = encoding!
    }
}

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
