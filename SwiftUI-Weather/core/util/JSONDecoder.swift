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
       var customIsoFormatter = DateFormatter.apiDateHourFormat
       
       if let date = customIsoFormatter.date(from: dateStr) {
           return date
       }
       
       customIsoFormatter = DateFormatter.apiDateFormat
       
       if let date = customIsoFormatter.date(from: dateStr) {
           return date
       }
       
       Logger.statistics.error("INVALID DATE: \(dateStr)")
       
       throw DecodingError.dataCorrupted(
               DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date"))
   }
}
