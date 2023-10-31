//
//  WeatherHomeInjection.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 19/09/23.
//

import Foundation

struct WeatherHomeInjection {

    @Inject
    private var currentWeatherInteractor: CurrentWeatherInteractor
    
    @Inject
    private var forecastInteractor: ForecastWeatherInteractor
    
    func register() {
        let model = WeatherModel()
        DependencyInjectionContainer.register(WeatherModel.self, model)
        
        let intent = WeatherIntent(model: model, externalData: .init(), currentWeatherInteractor: self.currentWeatherInteractor, forecastInteractor: self.forecastInteractor)
        
        DependencyInjectionContainer.register(WeatherIntent.self, intent)
    }
}
