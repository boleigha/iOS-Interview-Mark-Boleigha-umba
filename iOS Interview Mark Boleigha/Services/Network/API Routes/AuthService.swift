//
//  AuthService.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//

import Foundation
import Alamofire

enum AuthService: Endpoint {
    
    case request_token
    case guest_login
    
    var url: URL? {
        guard let _url = URL(string: self.stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            return nil
        }
        return _url
    }
    
    var stringValue: String {
        guard let api_key = Bundle.main.infoDictionary?["API"] as? String else {
            return ""
        }
        switch self {
        case .request_token:
            return baseURL + "authentication/token/new?api_key=" + api_key
        case .guest_login:
            return baseURL + "authentication/guest_session/new?api_key=" + api_key
        }
    }
}
