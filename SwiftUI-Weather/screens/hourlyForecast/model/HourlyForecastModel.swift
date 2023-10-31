//
//  HourlyForecastModel.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import SwiftUI
import Combine
import OSLog

final class HourlyForecastModel: ObservableObject, HourlyForecastModelStatePotocol {
    @Published var contentState: HourlyForecastTypes.Model.ContentState = .loading
    let loadingText = "Loading"
    let navigationTitle = "SwiftUI Videos"
    let routerSubject = HourlyForecastRouter.Subjects()
}

// MARK: - Actions Protocol

extension HourlyForecastModel: HourlyForecastActionsProtocol {

    func dispalyLoading() {
        contentState = .loading
    }
    
    func updateForecast(forecast: ForecastResponse) {
        contentState = .contentForecast(forecastResponse: forecast)
    }

    func dispalyError(_ error: Error) {
        contentState = .error(text: "Fail")
    }
    
    func dispalyErrorAlert(_ title: String, _ message: String) {
        contentState = .errorAlert(title, message)
    }
}

// MARK: - Route Protocol

extension HourlyForecastModel: HourlyForecastRouterProtocol {
    func noActionForNow() {
        
    }
}

// MARK: - Helper classes

extension HourlyForecastTypes.Model {
    enum ContentState {
        case loading
        case contentForecast(forecastResponse: ForecastResponse)
        case error(text: String)
        case errorAlert(_ title: String, _ message: String)
    }
}

