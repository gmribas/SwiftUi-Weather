//
//  WeatherModel.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI
import Combine
import OSLog

final class WeatherModel: ObservableObject, WeatherModelStatePotocol {
    @Published var contentState: WeatherTypes.Model.ContentState = .loading
    let loadingText = "Loading"
    let navigationTitle = "SwiftUI Videos"
    let routerSubject = WeatherRouter.Subjects()
}

// MARK: - Actions Protocol

extension WeatherModel: WeatherModelActionsProtocol {

    func dispalyLoading() {
        contentState = .loading
    }
    
    func updateForecast(location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse) {
        contentState = .contentForecast(location: location, currentCondition: currentCondition, forecastResponse: forecast)
    }

    func dispalyError(_ error: Error) {
        contentState = .error(text: "Fail")
    }
    
    func dispalyLocationDenied() {
        contentState = .errorAlert("Location Update", "Location has been denied")
    }
    
    func dispalyErrorAlert(_ title: String, _ message: String) {
        contentState = .errorAlert(title, message)
    }
}

// MARK: - Route Protocol

extension WeatherModel: WeatherModelRouterProtocol {
    func noActionForNow() {
        
    }
}

// MARK: - Helper classes

extension WeatherTypes.Model {
    enum ContentState {
        case loading
        case contentForecast(location: Location, currentCondition: CurrentCondition, forecastResponse: ForecastResponse)
        case error(text: String)
        case errorAlert(_ title: String, _ message: String)
    }
}
