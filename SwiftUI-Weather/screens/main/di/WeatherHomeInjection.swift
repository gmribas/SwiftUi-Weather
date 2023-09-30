//
//  WeatherHomeInjection.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 19/09/23.
//

import Foundation

struct WeatherHomeInjection {

    static func register() {
        let model = WeatherModel()
        DependencyInjectionContainer.register(WeatherModel.self, model)
        
        guard let currentWeatherInteractor = DependencyInjectionContainer.resolve(.automatic, CurrentWeatherInteractor.self) else {
            fatalError("No dependency of type CurrentWeatherInteractor registered!")
        }
        
        guard let forecastInteractor = DependencyInjectionContainer.resolve(.automatic, ForecastWeatherInteractor.self) else {
            fatalError("No dependency of type ForecastWeatherInteractor registered!")
        }
        
        DependencyInjectionContainer.register(WeatherIntent.self, WeatherIntent(model: model, externalData: .init(), currentWeatherInteractor: currentWeatherInteractor, forecastInteractor: forecastInteractor))
    }
}
