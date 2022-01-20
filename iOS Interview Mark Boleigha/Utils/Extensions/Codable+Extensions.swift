//
//  Codable+Extensions.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation

extension Dictionary {
    func customCodableObject<T: Codable>(type: T.Type) throws -> T? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [.fragmentsAllowed, .prettyPrinted]) else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let obj = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        return obj
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).map { $0 as? [String: Any] }!
    }
    
    var jsonData: Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .useDefaultKeys
        guard let data = try? encoder.encode(self) else { return nil }
        return data
    }
}
