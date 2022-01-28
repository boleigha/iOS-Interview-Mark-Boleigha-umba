//
//  MockRequest.swift
//  iOS Interview Mark BoleighaTests
//
//  Created by Mark Boleigha on 17/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import Alamofire
@testable import iOS_Interview_Mark_Boleigha


class MockRequest: NetworkService {
    
    var db: [String: Any]!
    
    init() {
        if let path = Bundle.main.path(forResource: "db", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves])
                if let jsonResult = json as? [String: Any] {
                    self.db = jsonResult
                } else {
                    print("could not cast json")
                }
            } catch {
                return
            }
        } else {
            print("could not load json")
        }
        
    }
    
    func request<T>(_ request: NetworkRequest, completion: @escaping (NetworkResponse, T?) -> Void) where T : Decodable, T : Encodable {
        let url = APITestClient(endpoint: request.endpoint)
        let part = url.stringValue
        
        guard let service = db["\(part)"] as? Dictionary<String, Any> else {
            print("failed to parse")
            return
        }
        
        do {
            let obj = try JSONSerialization.data(withJSONObject: service, options: [.fragmentsAllowed, .prettyPrinted])
            
            let persistentContainer = AppDelegate.shared.persistentContainer
            let managedObjectContext = persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = managedObjectContext
            
            let correct = try decoder.decode(T.self, from: obj)
            completion(.success, correct)
        } catch {
            print("error: \(error)")
            completion(.failed(NetworkError.api_error("Unable to decode object: \(error)")), nil)
        }
    }
    
    func buildRequestHeaders(encoding: RequestEncoding, apiKey: String?) -> HTTPHeaders {
        let http = HTTP(service: Network())
        return  http.buildRequestHeaders(encoding: encoding, apiKey: apiKey)
    }
}
