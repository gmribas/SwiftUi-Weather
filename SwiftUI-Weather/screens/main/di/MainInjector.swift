//
//  MainInjector.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import Foundation

struct MainInjection {
    
    @Inject
    private var currentWeatherInteractor: CurrentWeatherInteractor
    
    @Inject
    private var forecastInteractor: ForecastWeatherInteractor

    func register() {
        let model = MainModel()
        DependencyInjectionContainer.register(MainModel.self, model)
        
        DependencyInjectionContainer.register(IsNightChecker.self, IsNightChecker())
        
        let intent = MainIntent(model: model, externalData: .init(), currentWeatherInteractor: self.currentWeatherInteractor, forecastInteractor: self.forecastInteractor)
        DependencyInjectionContainer.register(MainIntent.self, intent)
    }
}
