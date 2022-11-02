//
//  KeyedDecodingContainer.swift
//  
//
//  Created by Omega on 02.11.2022.
//

import Foundation

public extension KeyedDecodingContainer {
    
    // MARK: - Decoding Int
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        if let decodedValue = try? decodeIfPresent(type, forKey: key) {
            return decodedValue
        }
        let stringValue = try decode(String.self, forKey: key)
        let decimal = NSDecimalNumber(string: stringValue)
        
        let error = DecodingError.dataCorruptedError(
            forKey: key,
            in: self,
            debugDescription: "Expected `\(Int.self)` but received `\(stringValue)`"
        )
        
        if decimal == .notANumber {
            throw error
        }
        
        return decimal.intValue
    }
    
    // MARK: - Decoding Double
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        if let decodedValue = try? decodeIfPresent(type, forKey: key) {
            return decodedValue
        }
        let stringValue = try decode(String.self, forKey: key)
        let decimal = NSDecimalNumber(string: stringValue)
        
        let error = DecodingError.dataCorruptedError(
            forKey: key,
            in: self,
            debugDescription: "Expected `\(Int.self)` but received `\(stringValue)`"
        )
        
        if decimal == .notANumber {
            throw error
        }
        
        return decimal.doubleValue
    }
    
    // MARK: - Decoding Json String
    
    func decode<T: Decodable>(_ type: String.Type, forKey key: Key) throws -> T {
        let jsonString = try decode(type, forKey: key)
        let jsonData = Data(jsonString.utf8)
        let wrappedObject = try JSONDecoder().decode(T.self, from: jsonData)
        return wrappedObject
    }
}
