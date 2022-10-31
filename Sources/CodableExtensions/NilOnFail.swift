//
//  NilOnFail.swift
//  fastmoney
//
//  Created by Sergey Aleksandrov on 14.09.2021.
//

import Foundation

public protocol OptionalCodingWrapper: Decodable {
    associatedtype WrappedType: ExpressibleByNilLiteral
    var wrappedValue: WrappedType { get }
    init(wrappedValue: WrappedType)
}

public extension KeyedDecodingContainer {
    // This is used to override the default decoding behavior for OptionalCodingWrapper to allow a value to avoid a missing key Error
    func decode<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T where T: OptionalCodingWrapper {
        try decodeIfPresent(T.self, forKey: key) ?? T(wrappedValue: nil)
    }
}

@propertyWrapper
public struct NilOnFail<WrappedType>: Equatable, OptionalCodingWrapper where WrappedType: Decodable, WrappedType: Equatable {

    public var wrappedValue: WrappedType?

    public init(wrappedValue: WrappedType?) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) {
        if let singleContainer = try? decoder.singleValueContainer() {
            self.wrappedValue = try? singleContainer.decode(WrappedType.self)
        } else {
            self.wrappedValue = try? WrappedType(from: decoder)
        }
    }
}
