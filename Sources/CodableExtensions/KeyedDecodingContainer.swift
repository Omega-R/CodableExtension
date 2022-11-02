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
    
    // MARK: - Decoding Bool
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        if let decodedValue = try? decodeIfPresent(type, forKey: key) {
            return decodedValue
        }
        
        let stringValue = try? decodeIfPresent(String.self, forKey: key)
        let intValue = try? decodeIfPresent(Int.self, forKey: key)
        let result = stringValue.map(Int.init) ?? intValue
        
        switch result {
        case 0:
            return false
        case 1:
            return true
        case .none:
            return false
        default:
            throw DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: "Expected `0` or `1` but received `\(result!.description)`")
        }
    }
}
