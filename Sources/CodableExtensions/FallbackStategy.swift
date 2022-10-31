//
//  FallbackStategy.swift
//  
//
//  Created by Omega on 31.10.2022.
//

import Foundation

public enum FallbackStategy {
    
    public enum Zero<T: AdditiveArithmetic>: Fallback {
        public static var defaultValue: T { .zero }
    }
    
    public enum True: Fallback {
        public static var defaultValue: Bool { true }
    }
    
    public enum False: Fallback {
        public static var defaultValue: Bool { false }
    }
    
    public enum EmptyString<T: ExpressibleByStringLiteral>: Fallback {
        public static var defaultValue: T { "" }
    }
    
    public enum EmptyArray<T: ExpressibleByArrayLiteral>: Fallback {
        public static var defaultValue: T { [] }
    }
    
    public enum EmptyDictionary<T: ExpressibleByDictionaryLiteral>: Fallback {
        public static var defaultValue: T { [:] }
    }
}
