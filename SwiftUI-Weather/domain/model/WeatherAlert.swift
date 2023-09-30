//
//  Alert.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//

import Foundation

struct WeatherAlert: Codable {
    let headline, msgtype, severity, urgency: String
    let areas, category, certainty, event: String
    let note: String
    let effective, expires: Date
    let desc, instruction: String
}
