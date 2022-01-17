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
    func request<T>(_ request: NetworkRequest, completion: @escaping (NetworkResponse, T?) -> Void) where T : Decodable, T : Encodable {
        
    }
    
    func buildRequestHeaders(encoding: RequestEncoding, apiKey: String?) -> HTTPHeaders {
        let http = HTTP(service: Network())
        return  http.buildRequestHeaders(encoding: encoding, apiKey: apiKey)
    }
}
