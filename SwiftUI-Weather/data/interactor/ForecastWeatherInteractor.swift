//
//  ForecastWeatherInteractor.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 29/09/23.
//

import Foundation
import Combine

protocol ForecastWeatherInteractor {
    func getForecast(location: String) -> AnyPublisher<ForecastResponse?, Error>
}

struct ForecastWeatherInteractorImpl: ForecastWeatherInteractor {
    
    private var repository: ForecastWeatherRemoteRepository
    
    init(repository: ForecastWeatherRemoteRepository) {
        self.repository = repository
    }
    
    func getForecast(location: String) -> AnyPublisher<ForecastResponse?, Error> {
        return repository.getForecast(location: location)
    }
}
