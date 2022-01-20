//
//  MovieDBService.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation
import Alamofire

enum MovieDBService: Endpoint {
    
    case latest
    case upcoming
    case popular
    case get_image(path: String)
    
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
        case .latest:
            return baseURL + "movie/latest?api_key=" + api_key + "&language=en-US"
        case .popular:
            return baseURL + "movie/popular?api_key=" + api_key
        case .upcoming:
            return baseURL + "movie/upcoming?api_key=" + api_key
        case .get_image(let path):
            return "https://image.tmdb.org/t/p/w500" + path
        }
    }
}
