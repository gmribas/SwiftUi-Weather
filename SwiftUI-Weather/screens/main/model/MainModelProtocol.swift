//
//  MainViewModelProtocol.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import Foundation

// MARK: - View State

protocol MainModelStatePotocol {
    var contentState: MainTypes.Model.ContentState { get }
    var routerSubject: MainRouter.Subjects { get }
}

// MARK: - Intent Actions

protocol MainModelActionsProtocol: AnyObject {
    func dispalyLoading()
    func updateForecast(location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse)
    func dispalyError(_ error: Error)
    func dispalyErrorAlert(_ title: String, _ message: String)
    func dispalyLocationDenied()
    func alredyExecuted() -> Bool
    func setAsExecuted()
}


// MARK: - Route

protocol MainModelRouterProtocol: AnyObject {
    func noActionForNow()
}
