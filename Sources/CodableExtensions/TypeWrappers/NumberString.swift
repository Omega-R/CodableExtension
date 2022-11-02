//
//  NumberString.swift
//  fastmoney
//
//  Created by Sergey Aleksandrov on 04.10.2022.
//

import Foundation

@propertyWrapper
public struct NumberString<T: Decodable>: Decodable {
    
    public let wrappedValue: T
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let decodedValue = try? container.decode(T.self) {
            wrappedValue = decodedValue
        } else {
            let stringValue = try container.decode(String.self)
            let decimal = NSDecimalNumber(string: stringValue)
            
            let error = DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected `\(T.self)` but received `\(stringValue)`")
            
            if decimal == .notANumber {
                throw error
            }
            
            wrappedValue = try {
                switch T.self {
                case is Double.Type:
                    return decimal.doubleValue as! T
                case is Float.Type:
                    return decimal.floatValue as! T
                case is Int.Type:
                    return decimal.intValue as! T
                default:
                    throw error
                }
            }()
        }
    }
}
