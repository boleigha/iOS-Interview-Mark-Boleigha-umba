//
//  Request.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//

import Foundation
import Alamofire
import Combine

struct RequestManager {
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        let sessionManager = Session(configuration: configuration, delegate: SessionDelegate(), serverTrustManager: nil)
        return sessionManager
    }()
}

enum RequestEncoding {
    case json
    case url
    case urlJson
    case upload
    
    var get: ParameterEncoding {
        switch self {
        case .json, .upload:
            return JSONEncoding.default
        case .url, .urlJson:
            return URLEncoding.default
        }
    }
    
    var contentType: (name: String, value: String) {
        switch self {
        case .json, .urlJson:
            return (name: "Content-Type", value: "application/json")
        case .url:
            return (name: "Content-Type", value: "application/x-www-form-urlencoded")
        case .upload:
            return (name: "Content-type", value: "multipart/form-data")
        }
    }
}

class HTTP {
    static let shared = HTTP(service: Network())
    var service: NetworkService!
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func buildRequestHeaders(encoding: RequestEncoding, apiKey: String? = nil) -> HTTPHeaders {
        return self.service.buildRequestHeaders(encoding: .json, apiKey: apiKey)
    }
    
    func request<T>(_ request: NetworkRequest, completion: @escaping (NetworkResponse, T?) -> Void) where T : Decodable, T : Encodable {
        self.service.request(request) { (response, _ data: T?) in
            completion(response, data)
        }
    }
}



class Network: NetworkService {

    func buildRequestHeaders(encoding: RequestEncoding, apiKey: String? = nil) -> HTTPHeaders {
        var headers: HTTPHeaders = ["Accept" : "application/json"]
        headers.add(name: encoding.contentType.name, value: encoding.contentType.value)
        
        if apiKey != nil {
            headers.add(name: "Authorization", value: apiKey!)
        }
        
        return headers
    }
    
    func request<T>(_ request: NetworkRequest, completion: @escaping (NetworkResponse, T?) -> Void) where T : Decodable, T : Encodable {
        let headers = buildRequestHeaders(encoding: request.encoding)
        
        RequestManager.shared.request(request.endpoint.url!, method: request.method, parameters: request.body, encoding: request.encoding.get, headers: headers).response { response in
            self.response(response) { (status, _ response: T?) in
                completion(status, response)
            }
        }
    }
    
    func response<T: Codable>(_ response: AFDataResponse<Data?>,_ completion: @escaping (NetworkResponse, T?) -> Void) {
        switch(response.response?.statusCode) {
        case 200, 201:
            if let jsonData = response.data {
                if let json = try? JSONDecoder().decode(T.self, from: jsonData) {
                    completion(.success, json)
                    return
                }
                
                do {
                    let obj = try JSONSerialization.jsonObject(with: jsonData, options: [.fragmentsAllowed, .allowFragments])
                    let data = try JSONSerialization.data(withJSONObject: obj, options: [.fragmentsAllowed, .prettyPrinted])
                    
                    do {
                        let serialized = try JSONDecoder().decode(T.self, from: data)
                        print("serialized: \(serialized)")
                        completion(.success, serialized)
                    } catch(let error) {
                        completion(.success, nil)
                        print("error on serialize:  \(error)")
                    }
                } catch {
                    print("error: \(error)")
                }
            } else {
                completion(.success, nil)
            }
        case 400, 401, 403, 404, 422:
            completion(.failed(.unknown("An unknown error has occured, please try again")), nil)
        default:
            RequestManager.shared.cancelAllRequests()
            completion(.failed(.unknown("Your internet connection appears to be offline")), nil)
        }
    }
    
}
