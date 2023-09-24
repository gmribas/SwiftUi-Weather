//
//  InteractorDependencyInjection.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

import Foundation

struct InteractorDependencyInjection {
    
    func register() throws {
        guard let repo = DependencyInjectionContainer.resolve(.automatic, CurrentWeatherRemoteRepository.self) else {
            fatalError("No dependency of type CurrentWeatherRemoteRepository registered!")
        }
        
        DependencyInjectionContainer.register(CurrentWeatherInteractor.self, CurrentWeatherInteractorImpl(repository: repo))
    }
}
