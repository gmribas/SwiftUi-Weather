//
//  WeatherIntentProtocol.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//
import Combine

protocol WeatherIntentProtocol {
    func viewOnAppear(forecast: ForecastResponse)
    func getSunsetCondition(forecastday: Forecastday)
    func getTomorrowCondition(forecastday: Forecastday)
}
