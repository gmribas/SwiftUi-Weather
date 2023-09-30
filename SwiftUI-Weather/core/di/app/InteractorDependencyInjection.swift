//
//  InteractorDependencyInjection.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

import Foundation

class InteractorDependencyInjection {
    
    func register() throws {
        guard let currentWeatherRepo = DependencyInjectionContainer.resolve(.automatic, CurrentWeatherRemoteRepository.self) else {
            fatalError("No dependency of type CurrentWeatherRemoteRepository registered!")
        }
        
        guard let forecastRepo = DependencyInjectionContainer.resolve(.automatic, ForecastWeatherRemoteRepository.self) else {
            fatalError("No dependency of type ForecastWeatherRemoteRepository registered!")
        }
        
        DependencyInjectionContainer.register(CurrentWeatherInteractor.self, CurrentWeatherInteractorImpl(repository: currentWeatherRepo))
        
        DependencyInjectionContainer.register(ForecastWeatherInteractor.self, ForecastWeatherInteractorImpl(repository: forecastRepo))
    }
}
