//
//  JsonString.swift
//  fastmoney
//
//  Created by Omega on 01.11.2022.
//

import Foundation

@propertyWrapper
public struct JsonString<T: Codable>: Codable {
    
    public let wrappedValue: T
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let object = try? container.decode(T.self) {
            wrappedValue = object
        } else {
            let jsonString = try container.decode(String.self)
            let jsonData = Data(jsonString.utf8)
            wrappedValue = try JSONDecoder().decode(T.self, from: jsonData)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
