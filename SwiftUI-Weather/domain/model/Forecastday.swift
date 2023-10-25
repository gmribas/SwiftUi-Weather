//
//  Forecastday.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//
import Foundation

struct Forecastday: Codable {
    let date: Date
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
