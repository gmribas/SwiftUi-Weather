//
//  JSONDecoder.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import Foundation
import OSLog

extension JSONDecoder.DateDecodingStrategy {
    
   static var iso8601yyyyMMdd = custom { decoder in
       let dateStr = try decoder.singleValueContainer().decode(String.self)
       
       if let date = DateFormatter.apiDateHourFormat.date(from: dateStr) {
           return date
       }
       
       if let date = DateFormatter.apiDateFormat.date(from: dateStr) {
           return date
       }
       
       if let date = DateFormatter.apiHourMinuteFormat.date(from: dateStr) {
           let hour = Calendar.current.component(.hour, from: date)
           let minute = Calendar.current.component(.minute, from: date)
           let second = Calendar.current.component(.second, from: date)
           let correctDateTime = Calendar.current.date(bySettingHour: hour, minute: minute, second: second, of: Date())
           
           if let c = correctDateTime {
               return c
           }
           
           Logger.statistics.error("PROBLEMS DEFINING CORRECT DATE FOR: \(dateStr)")
           
           return date
       }
       
       if Astro.isAstroDateFuckedUp(dateString: dateStr) {
           Logger.statistics.error("INVALID MOFO Astro DATE: \(dateStr)")
           return Date()
       }
       
       Logger.statistics.error("INVALID DATE: \(dateStr)")
       
       throw DecodingError.dataCorrupted(
               DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date"))
   }
}
