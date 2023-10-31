//
//  HourlyForecastHomeInjection.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import Foundation

struct HourlyForecastHomeInjection {

    @Inject
    private var forecastInteractor: ForecastWeatherInteractor
    
    func register() {
        let model = HourlyForecastModel()
        
        DependencyInjectionContainer.register(HourlyForecastModel.self, model)
        
        DependencyInjectionContainer.register(HourlyForecastIntent.self, HourlyForecastIntent(model: model, externalData: .init(), forecastInteractor: self.forecastInteractor))
    }
}
