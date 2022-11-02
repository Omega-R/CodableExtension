//
//  JsonString.swift
//  fastmoney
//
//  Created by Omega on 01.11.2022.
//

import Foundation

@propertyWrapper
public struct JsonString<T: Decodable>: Decodable {
    
    public let wrappedValue: T
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let jsonString = try container.decode(String.self)
        let jsonData = Data(jsonString.utf8)
        wrappedValue = try JSONDecoder().decode(T.self, from: jsonData)
    }
}
