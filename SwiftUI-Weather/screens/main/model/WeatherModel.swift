//
//  WeatherModel.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI
import Combine

final class WeatherModel: ObservableObject, WeatherModelStatePotocol {

    @Published var contentState: WeatherTypes.Model.ContentState = .loading

    let loadingText = "Loading"
    let navigationTitle = "SwiftUI Videos"
    let routerSubject = WeatherRouter.Subjects()
    
    func checkIfIsNightTime() -> Bool {
      let date = NSDate()
      let calendar = NSCalendar.current
      let currentHour = calendar.component(.hour, from: date as Date)
      let hourInt = Int(currentHour.description)!
      
      let NEW_DAY = 0
      let NOON = 12
      let SUNSET = 18
      let MIDNIGHT = 24

      var greetingText = false
      if hourInt >= NEW_DAY && hourInt <= NOON {
          greetingText = false
      }
      else if hourInt > NOON && hourInt <= SUNSET {
          greetingText = false
      }
      else if hourInt > SUNSET && hourInt <= MIDNIGHT {
          greetingText = true
      }
      
      return greetingText
    }
}

// MARK: - Actions Protocol

extension WeatherModel: WeatherModelActionsProtocol {

    func dispalyLoading() {
        contentState = .loading
    }
    
    func updateForecast(location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse) {
        contentState = .contentForecast(location: location, currentCondition: currentCondition, forecast: forecast)
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
        case contentForecast(location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse)
        case error(text: String)
        case errorAlert(_ title: String, _ message: String)
    }
}
