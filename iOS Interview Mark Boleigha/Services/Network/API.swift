//
//  API.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//

import Foundation
 let baseURL = "https://api.themoviedb.org/3/"

protocol Endpoint {
    var url: URL? { get }
    var stringValue: String { get }
}

enum API {
    case auth(AuthService)
    
    var url: URL? {
        switch self {
        case .auth(let route):
            return route.url
        }
    }
    
    var stringValue: String {
        switch self {
        case .auth(let route):
            return route.stringValue
        }
    }
}
