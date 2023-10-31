//
//  HourlyForecastModelStatePotocol.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import Foundation

// MARK: - View State

protocol HourlyForecastModelStatePotocol {
    var contentState: HourlyForecastTypes.Model.ContentState { get }
    var loadingText: String { get }
    var navigationTitle: String { get }

    var routerSubject: HourlyForecastRouter.Subjects { get }
}

// MARK: - Intent Actions

protocol HourlyForecastActionsProtocol: AnyObject {
    func dispalyLoading()
    func updateForecast(forecast: ForecastResponse)
    func dispalyError(_ error: Error)
    func dispalyErrorAlert(_ title: String, _ message: String)
}


// MARK: - Route

protocol HourlyForecastRouterProtocol: AnyObject {
    func noActionForNow()
}
