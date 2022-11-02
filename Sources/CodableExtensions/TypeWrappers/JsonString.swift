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
        let jsonDecoder = JSONDecoder()
        
        if let decodedObject = try? jsonDecoder.decode(T.self, from: jsonData) {
            wrappedValue = decodedObject
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown object to parce in \(jsonString)")
        }
    }
}
