//
//  Astro.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//

import Foundation

struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset: Date?
    let moonPhase: String
    let moonIllumination: Double
    let isMoonUp, isSunUp: Int?

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
    
    static func isAstroDateFuckedUp(dateString: String) -> Bool {
        let fuckedUpValues = ["sunrise", "sunset", "moonrise", "moonset"]
        
        for s in fuckedUpValues {
            if dateString.contains(s) {
                return true
            }
        }
        
        return false
    }
}
