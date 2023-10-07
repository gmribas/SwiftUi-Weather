//
//  ForecastRestul.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//

struct ForecastResponse: Codable {
    let location: Location
    let current: CurrentCondition
    let forecast: Forecast?
    let alerts: WeatherAlerts?
}
