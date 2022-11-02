//
//  OptionalDate.swift
//  
//
//  Created by Omega on 02.11.2022.
//

import Foundation

@propertyWrapper
public struct OptionalDate: Decodable {
    
    public let wrappedValue: Date?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard let decodedString = try? container.decode(String.self) else {
            wrappedValue = nil
            return
        }
        
        if decodedString.isEmpty {
            wrappedValue = nil
        } else if let date = DateFormat.date(from: decodedString) {
            wrappedValue = date
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported date format: `\(decoder.codingPath)`")
        }
    }
}
