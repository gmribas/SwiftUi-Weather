//
//  Astro.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//

struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset, moonPhase, moonIllumination: String
    let isMoonUp, isSunUp: Int

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
}
