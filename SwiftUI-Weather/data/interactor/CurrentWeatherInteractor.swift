//
//  CurrentWeatherInteractor.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

import Combine
import Foundation

protocol CurrentWeatherInteractor {
    func getCurrentWeather(location: String) -> AnyPublisher<CurrentConditionResponse?, Error>
}

struct CurrentWeatherInteractorImpl: CurrentWeatherInteractor {
    
    private var repository: CurrentWeatherRemoteRepository
    
    init(repository: CurrentWeatherRemoteRepository) {
        self.repository = repository
    }
    
    func getCurrentWeather(location: String) -> AnyPublisher<CurrentConditionResponse?, Error> {
        return repository.getCurrentWeather(location: location)
    }
}
