//
//  APITestClient.swift
//  iOS Interview Mark BoleighaTests
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
@testable import iOS_Interview_Mark_Boleigha

struct APITestClient {
    
    var endpoint: API!
    
    init(endpoint: API) {
        self.endpoint = endpoint
    }
    
    var stringValue: String {
        switch endpoint {
        case .movies(_):
            return "movies"
        case .none:
            return ""
        case .some(.auth(_)):
            return ""
        }
    }
}
