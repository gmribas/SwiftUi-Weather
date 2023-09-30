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
    
    func checkIfIsNightTime() -> Bool
}

// MARK: - Intent Actions

protocol WeatherModelActionsProtocol: AnyObject {
    func dispalyLoading()
    func updateCurrentCondition(location: Location, currentCondition: CurrentCondition)
    func updateForecast(forecast: ForecastResponse)
    func dispalyError(_ error: Error)
}


// MARK: - Route

protocol WeatherModelRouterProtocol: AnyObject {
    func noActionForNow()
}
