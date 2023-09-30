//
//  ForecastWeatherRemoteRepository.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//

import Foundation
import Combine

protocol ForecastWeatherRemoteRepository: WebRepository {
    
    func getForecast(location: String) -> AnyPublisher<ForecastResponse?, Error>
}
