//
//  Constants.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation


struct Constants {
    static let WEATHER_API_KEY = "dd57e5c45f7145ff8f6181806232611"
    static let WEATHER_BASE_URL = "https://api.weatherapi.com/v1"
    static let CURRENT_WEATHER = "/current.json?key=\(Constants.WEATHER_API_KEY)"
    static let FORECAST = "/forecast.json?key=\(Constants.WEATHER_API_KEY)"
    static let FORECAST_MAX_DAYS_FREE_PLAN = "3"
    static let LANGUAGE_PT = "lang=pt"
    static let API_DATE_HOUR_FORMAT = "yyyy-MM-dd HH:mm"
    static let API_DATE_FORMAT = "yyyy-MM-dd"
    static let DAY_MONTH_YEAR_DATE_FORMAT = "dd/MM/yyyy"
    static let HOUR_MINUTE_DATE_FORMAT = "hh:mm a"
    static let DAY_OF_THE_WEEK_DATE_FORMAT = "EEEE"
    
    static let ERROR_VALUE: Double = -9999
}

