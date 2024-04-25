//
//  WeatherAndTemperatureProtocol.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import Foundation

// MARK: - View State

protocol WeatherModelStatePotocol {
    var sunsetState: WeatherTypes.Model.SunsetState { get }
    var tomorrowState: WeatherTypes.Model.TomorrowState { get }
    var routerSubject: WeatherRouter.Subjects { get }
    var today: Forecastday? { get }
    var tomorrow: Forecastday? { get }
}

// MARK: - Intent Actions

protocol WeatherModelActionsProtocol: AnyObject {
    func showCurrentHourCondition(hour: Hour)
    func showCurrentHourConditionError()
    func showTomorrow(tomorrow: TomorrowConditionDTO)
    func showTomorrowError()
}


// MARK: - Route

protocol WeatherModelRouterProtocol: AnyObject {
    func noActionForNow()
}
