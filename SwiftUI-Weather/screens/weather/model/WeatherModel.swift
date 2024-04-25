//
//  WeatherModel.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI
import Combine

final class WeatherModel: ObservableObject, WeatherModelStatePotocol {
    @Published var sunsetState: WeatherTypes.Model.SunsetState = .none
    
    @Published var tomorrowState: WeatherTypes.Model.TomorrowState = .none
    
    let routerSubject = WeatherRouter.Subjects()
    
    internal var today: Forecastday? = nil
    
    internal var tomorrow: Forecastday? = nil
}

// MARK: - Actions Protocol

extension WeatherModel: WeatherModelActionsProtocol {

    func showCurrentHourCondition(hour: Hour) {
        self.sunsetState = .showSunsetCondition(hour)
    }
    
    func showCurrentHourConditionError() {
        self.sunsetState = .showSunsetConditionError
    }
    
    func showTomorrow(tomorrow: TomorrowConditionDTO) {
        self.tomorrowState = .showTomorrow(tomorrow: tomorrow)
    }
    
    func showTomorrowError() {
        self.tomorrowState = .showTomorrowError
    }
}

// MARK: - Route Protocol

extension WeatherModel: WeatherModelRouterProtocol {
    func noActionForNow() {
        
    }
}

// MARK: - Helper classes

extension WeatherTypes.Model {
    enum SunsetState {
        case none
        case showSunsetCondition(_ hour: Hour)
        case showSunsetConditionError
    }
    
    enum TomorrowState {
        case none
        case showTomorrow(tomorrow: TomorrowConditionDTO)
        case showTomorrowError
    }
}
