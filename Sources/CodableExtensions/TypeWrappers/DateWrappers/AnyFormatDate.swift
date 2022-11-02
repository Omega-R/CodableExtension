//
//  AnyFormatDate.swift
//  
//
//  Created by Omega on 02.11.2022.
//

import Foundation

@propertyWrapper
public struct AnyFormatDate: Decodable {
    
    public let wrappedValue: Date
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let decodedString = try container.decode(String.self)
        
        if let date = DateFormat.date(from: decodedString) {
            wrappedValue = date
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported date format: `\(decoder.codingPath)`")
        }
    }
}
