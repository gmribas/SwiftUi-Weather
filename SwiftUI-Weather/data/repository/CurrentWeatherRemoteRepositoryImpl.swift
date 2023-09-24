//
//  CurrentWeatherRepositoryImpl.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

import Combine
import Foundation

struct CurrentWeatherRemoteRepositoryImpl: CurrentWeatherRemoteRepository {

    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
       
    init(session: URLSession) {
        self.session = session
        self.baseURL = Constants.WEATHER_BASE_URL
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
            return Constants.CURRENT_WEATHER + "&aqi=yes&q=" + location
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
