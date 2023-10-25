//
//  CurrentWeatherRepositoryImpl.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

import Combine
import Foundation

struct CurrentWeatherRemoteRepositoryImpl: CurrentWeatherRemoteRepository {
    
    internal var session: URLSession
    
    internal var baseURL: String = Constants.WEATHER_BASE_URL
    
    internal var bgQueue: DispatchQueue
    
    var jsonDecoder: JSONDecoder
    
    init(session: URLSession, bgQueue: DispatchQueue, jsonDecoder: JSONDecoder) {
        self.session = session
        self.bgQueue = bgQueue
        self.jsonDecoder = jsonDecoder
    }
    
    func getCurrentWeather(location: String) -> AnyPublisher<CurrentConditionResponse?, Error> {
        return call(endpoint: API.currentWeather(location))
    }
}

// MARK: - Endpoints

extension CurrentWeatherRemoteRepositoryImpl {
    enum API {
        case currentWeather(String)
    }
}

extension CurrentWeatherRemoteRepositoryImpl.API: APICall {
    var path: String {
        switch self {
        case .currentWeather(let location):
            return  "\(Constants.CURRENT_WEATHER)&aqi=yes&q=\(location)"
        }
    }
    var method: String {
        switch self {
        case .currentWeather:
            return "GET"
        }
    }
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    func body() throws -> Data? {
        return nil
    }
}
