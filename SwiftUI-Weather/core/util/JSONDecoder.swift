//
//  JSONDecoder.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import Foundation

extension JSONDecoder.DateDecodingStrategy {
    
   static var iso8601yyyyMMdd = custom { decoder in
       
       let dateStr = try decoder.singleValueContainer().decode(String.self)
       let customIsoFormatter = DateFormatter.yyyyMMdd
       if let date = customIsoFormatter.date(from: dateStr) {
           return date
       }
      throw DecodingError.dataCorrupted(
               DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid date"))
   }
}
