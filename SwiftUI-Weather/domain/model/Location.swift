//
//  Location.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

struct Location: Codable {
    let name, region, country: String
    let lat: Double
    let lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
