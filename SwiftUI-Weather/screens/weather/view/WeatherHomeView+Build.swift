//
//  WeatherView+Build.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI

extension WeatherHomeView {

    static func build(isNightChecker: IsNightChecker, location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse) -> WeatherHomeView {
        let view = WeatherHomeView(
            isNightChecker: Binding.constant(isNightChecker),
            location: Binding.constant(location),
            currentCondition: Binding.constant(currentCondition),
            forecast: Binding.constant(forecast)
        )
        
        return view
    }
}
