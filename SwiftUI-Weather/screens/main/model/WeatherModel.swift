//
//  WeatherModel.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI

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

    func updateCurrentCondition(location: Location, currentCondition: CurrentCondition) {
        contentState = .contentCurrentCondition(location: location, currentCondition: currentCondition)
    }
    
    func updateForecast(forecast: ForecastResponse) {
        contentState = .contentForecast(forecast: forecast)
    }

    func dispalyError(_ error: Error) {
        contentState = .error(text: "Fail")
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
        case contentCurrentCondition(location: Location, currentCondition: CurrentCondition)
        case contentForecast(forecast: ForecastResponse)
        case error(text: String)
    }
}
