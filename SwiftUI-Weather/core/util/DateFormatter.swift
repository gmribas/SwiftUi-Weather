//
//  DateFormatter.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import Foundation

extension DateFormatter {

    static let apiDateHourFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.API_DATE_HOUR_FORMAT
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.locale = Locale.current
        return formatter
    }()

    static let apiDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.API_DATE_FORMAT
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.locale = Locale.current
        return formatter
    }()

    static let apiHourMinuteFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.HOUR_MINUTE_DATE_FORMAT
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        formatter.locale = Locale.current
        return formatter
    }()
    
    static func formatWith(date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
