//
//  Constants.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation


struct Constants {
    static let WEATHER_API_KEY = "4345a3018c9d433caa8190801231609"
    static let WEATHER_BASE_URL = "https://api.weatherapi.com/v1"
    static let CURRENT_WEATHER = "/current.json?key=\(Constants.WEATHER_API_KEY)"
    static let FORECAST = "/forecast.json?key=\(Constants.WEATHER_API_KEY)"
}

