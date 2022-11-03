//
//  DefaultDecodable.swift
//  fastmoney
//
//  Created by Omega on 31.10.2022.
//

import Foundation

public protocol Fallback {
    associatedtype Value
    static var defaultValue: Value { get }
}

@propertyWrapper
public struct Defaulted<T: Fallback> {

    public var wrappedValue: T.Value

    public init(wrappedValue: T.Value) {
        self.wrappedValue = wrappedValue
    }
}

extension Defaulted: Decodable where T.Value: Decodable {
    public init(from decoder: Decoder) throws {
        let value = try T.Value(from: decoder)
        self.init(wrappedValue: value)
    }
}

extension Defaulted: Encodable where T.Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

public extension KeyedDecodingContainer {
    
    func decode<Fallback>(_ type: Defaulted<Fallback>.Type, forKey key: Key)
    throws -> Defaulted<Fallback> where Fallback.Value: Decodable
    {
        try decodeIfPresent(type, forKey: key) ?? Defaulted(wrappedValue: Fallback.defaultValue)
    }
}
