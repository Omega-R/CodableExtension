//
//  DateConverter.swift
//  
//
//  Created by Omega on 02.11.2022.
//

import Foundation

public struct DateConverter {

    public static var supportedFormats = [
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
        "yyyy-MM-dd",
        "yyyy-MM-dd'T'HH:mm:ss"
    ]
    
    public static func date(from string: String) -> Date? {
        for format in supportedFormats {
            if let date = getDateFromString(string, format) {
                return date
            }
        }
        return nil
    }
    
    public static func getDateFromString(_ dateString: String, _ format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
}


