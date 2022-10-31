//
//  BoolFromAny.swift
//  fastmoney
//
//  Created by Sergey Aleksandrov on 30.03.2022.
//  Copyright © 2022 Omega-R. All rights reserved.
//

import Foundation

@propertyWrapper
public struct BoolFromAny: Decodable {
    
    public let wrappedValue: Bool
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let boolValue = try? container.decode(Bool.self) {
            wrappedValue = boolValue
        } else {
            let stringValue = try? container.decode(String.self)
            let intValue = try? container.decode(Int.self)
            let result = stringValue.map(Int.init) ?? intValue
            switch result {
            case 0:
                wrappedValue = false
            case 1:
                wrappedValue = true
            case .none:
                wrappedValue = false
            default:
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Expected `0` or `1` but received `\(result!.description)`")
            }
        }
    }
}
