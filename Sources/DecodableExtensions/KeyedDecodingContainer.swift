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
        
        let decimal = try decodeDecimal(type, forKey: key)
        return decimal.intValue
    }
    
    // MARK: - Decoding Double
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        if let decodedValue = try? decodeIfPresent(type, forKey: key) {
            return decodedValue
        }
        
        let decimal = try decodeDecimal(type, forKey: key)
        return decimal.doubleValue
    }
    
    // MARK: - Decoding Float
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        if let decodedValue = try? decodeIfPresent(type, forKey: key) {
            return decodedValue
        }
        
        let decimal = try decodeDecimal(type, forKey: key)
        return decimal.floatValue
    }
    
    // MARK: - Decode Decimal
    
    private func decodeDecimal<T: Decodable>(_ type: T.Type, forKey key: Key) throws -> NSDecimalNumber {
        let stringValue = try decode(String.self, forKey: key)
        let decimal = NSDecimalNumber(string: stringValue)
        
        if decimal == .notANumber {
            throw DecodingError.dataCorruptedError(
                forKey: key,
                in: self,
                debugDescription: "Expected `\(type)` but received `\(stringValue)`"
            )
        }
        
        return decimal
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
    
    // MARK: - Decode Date
    
    func decode(_ type: Date.Type, forKey key: Key) throws -> Date {
        if let decodedValue = try decodeIfPresent(type, forKey: key) {
            return decodedValue
        }
        let stringValue = try decode(String.self, forKey: key)
        throw DecodingError.dataCorruptedError(
            forKey: key,
            in: self,
            debugDescription: "Unsupported date format: `\(stringValue)`"
        )
    }
    
    // MARK: - Decode Optional Date
    
    func decodeIfPresent(_ type: Date.Type, forKey key: Key) throws -> Date? {
        guard let stringValue = try? decode(String.self, forKey: key), !stringValue.isEmpty else {
            return nil
        }
        
        let date = try decodeDate(stringValue, forKey: key)
        return date
    }
    
    private func decodeDate(_ stringValue: String, forKey key: Key) throws -> Date {
        if let date = DateConverter.date(from: stringValue) {
            return date
        }
        
        throw DecodingError.dataCorruptedError(
            forKey: key,
            in: self,
            debugDescription: "Unsupported date format: `\(stringValue)`"
        )
    }
}
