//
//  DateFormat.swift
//  
//
//  Created by Omega on 02.11.2022.
//

import Foundation

struct DateFormat {
    static let utc = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let shortUtc = "yyyy-MM-dd"
    static let localDateTime = "yyyy-MM-dd'T'HH:mm:ss"
    
    static var supportedFormats = [
        utc,
        shortUtc,
        localDateTime
    ]
    
    static func date(from string: String) -> Date? {
        for format in supportedFormats {
            if let date = DateFormat.getDateFromString(string, format) {
                return date
            }
        }
        return nil
    }
    
    static func getDateFromString(_ dateString: String, _ format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
}


