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
        
        guard let interactor = DependencyInjectionContainer.resolve(.automatic, CurrentWeatherInteractor.self) else {
            fatalError("No dependency of type CurrentWeatherInteractor registered!")
        }
        DependencyInjectionContainer.register(WeatherIntent.self, WeatherIntent(model: model, externalData: .init(), interactor: interactor))
    }
}
