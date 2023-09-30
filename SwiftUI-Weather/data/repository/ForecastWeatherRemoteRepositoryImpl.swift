//
//  ForecastWeatherRemoteRepositoryImpl.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//

import Foundation
import Combine

struct ForecastWeatherRemoteRepositoryImpl: ForecastWeatherRemoteRepository {
    
    internal var session: URLSession
    
    internal let baseURL: String = Constants.WEATHER_BASE_URL
    
    internal var bgQueue: DispatchQueue
    
    init(session: URLSession, bgQueue: DispatchQueue) {
        self.session = session
        self.bgQueue = bgQueue
    }
    
    func getForecast(location: String) -> AnyPublisher<ForecastResponse?, Error> {
        return call(endpoint: API.forecast(location))
    }
}
//

// MARK: - Endpoints

extension ForecastWeatherRemoteRepositoryImpl {
    enum API {
        case forecast(String)
    }
}

extension ForecastWeatherRemoteRepositoryImpl.API: APICall {
    var path: String {
        switch self {
        case .forecast(let location):
            return "\(Constants.FORECAST)&q=\(location)&days=\(Constants.FORECAST_MAX_DAYS_FREE_PLAN)&alerts=yes&aqi=no&\(Constants.LANGUAGE_PT)"
        }
    }
    var method: String {
        switch self {
        case .forecast:
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
