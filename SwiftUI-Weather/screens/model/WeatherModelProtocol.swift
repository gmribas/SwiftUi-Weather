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
    func update(condition: CurrentConditionResponse)
    func dispalyError(_ error: Error)
}


// MARK: - Route

protocol WeatherModelRouterProtocol: AnyObject {
    func noActionForNow()
}
