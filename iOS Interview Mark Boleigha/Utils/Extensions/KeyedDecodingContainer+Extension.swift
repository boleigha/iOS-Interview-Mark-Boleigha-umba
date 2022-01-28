//
//  KeyedDecodingContainer+Extension.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 18/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    func decode(_ type: Decimal.Type, forKey key: K) throws -> Decimal {
        
        do {
            let stringValue = try decode(String.self, forKey: key)
            guard let decimalValue = Decimal(string: stringValue) else {
                let context = DecodingError.Context(codingPath: [key], debugDescription: "The key \(key) couldn't be converted to a Decimal value from string")
                throw DecodingError.typeMismatch(type, context)
            }
            return decimalValue
        } catch {
            do {
                let intValue = try decode(Double.self, forKey: key)
                let stringValue = String(intValue)
                guard let decimalValue = Decimal(string: stringValue) else {
                    let context = DecodingError.Context(codingPath: [key], debugDescription: "The key \(key) couldn't be converted to a Decimal value from double")
                    throw DecodingError.typeMismatch(type, context)
                }
                return decimalValue
            } catch {
                let context = DecodingError.Context(codingPath: [key], debugDescription: "The key \(key) couldn't be converted to a Decimal value at all")
                throw DecodingError.typeMismatch(type, context)
            }
        }
    }
    
    func decode(_ type: NSDecimalNumber.Type, forKey key: K) throws -> NSDecimalNumber {
        
        do {
            let stringValue = try decode(String.self, forKey: key)
            
//            guard let decimalValue = NSDecimalNumber(string: stringValue) else {
//                let context = DecodingError.Context(codingPath: [key], debugDescription: "The key \(key) couldn't be converted to a Decimal value from string")
//                throw DecodingError.typeMismatch(type, context)
//            }
            return NSDecimalNumber(string: stringValue)
//            return decimalValue
        } catch {
            do {
                let intValue = try decode(Double.self, forKey: key)
                let stringValue = String(intValue)
                let decimalValue = NSDecimalNumber(string: stringValue)
//                guard let decimalValue = NSDecimalNumber(string: stringValue) else {
//                    let context = DecodingError.Context(codingPath: [key], debugDescription: "The key \(key) couldn't be converted to a Decimal value from double")
//                    throw DecodingError.typeMismatch(type, context)
//                }
                return decimalValue
            } catch {
                let context = DecodingError.Context(codingPath: [key], debugDescription: "The key \(key) couldn't be converted to a Decimal value at all")
                throw DecodingError.typeMismatch(type, context)
            }
        }
    }
    
}
