//
//  CurrentWeatherRepository.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

import Foundation
import Combine

protocol CurrentWeatherRemoteRepository: WebRepository {
    
    func getCurrentWeather(location: String) -> AnyPublisher<CurrentConditionResponse?, Error>
}
