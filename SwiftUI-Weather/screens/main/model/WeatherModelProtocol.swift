//
//  WeatherAndTemperatureProtocol.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import Foundation

// MARK: - View State

protocol WeatherModelStatePotocol {
    var contentState: WeatherTypes.Model.ContentState { get }
    var loadingText: String { get }
    var navigationTitle: String { get }

    var routerSubject: WeatherRouter.Subjects { get }
}

// MARK: - Intent Actions

protocol WeatherModelActionsProtocol: AnyObject {
    func dispalyLoading()
    func updateForecast(location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse)
    func dispalyError(_ error: Error)
    func dispalyErrorAlert(_ title: String, _ message: String)
    func dispalyLocationDenied()
}


// MARK: - Route

protocol WeatherModelRouterProtocol: AnyObject {
    func noActionForNow()
}
