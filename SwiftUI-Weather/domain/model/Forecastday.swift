//
//  Forecastday.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//

struct Forecastday: Codable {
    let date: String
    let dateEpoch: Double
    let day: Day?
    let astro: Astro?
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}
