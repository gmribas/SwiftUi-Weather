//
//  WeeatherIntent.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI
import Combine
import CoreLocation
import OSLog

struct WeatherIntent {

    // MARK: Model

    private weak var model: WeatherModelActionsProtocol?
    
    private weak var routeModel: WeatherModelRouterProtocol?
    
    // MARK: Business Data

    private let externalData: WeatherTypes.Intent.ExternalData
    
    private let cancelBag = CancelBag()
    
    // MARK: Life cycle
    
    var isNightChecker = IsNightChecker()

    init(model: WeatherModelActionsProtocol & WeatherModelRouterProtocol,
         externalData: WeatherTypes.Intent.ExternalData,
         currentWeatherInteractor: CurrentWeatherInteractor,
         forecastInteractor: ForecastWeatherInteractor) {
        self.externalData = externalData
        self.model = model
        self.routeModel = model
    }
}

// MARK: - Public

extension WeatherIntent: WeatherIntentProtocol {
    
    func viewOnAppear(forecast: ForecastResponse) {
        let optionalToday = forecast.forecast?.forecastday?[0]
        let optionalTomorrow = forecast.forecast?.forecastday?[1]
        
        if let today = optionalToday {
            getSunsetCondition(forecastday: today)
        } else {
            Logger.statistics.error("forecastday today not found")
        }
        
        if let tomorrow = optionalTomorrow  {
            getTomorrowCondition(forecastday: tomorrow)
        }
        else {
            Logger.statistics.error("forecastday tomorrow not found")
        }
    }
    
    internal func getSunsetCondition(forecastday: Forecastday) {
        let subject = PassthroughSubject<Hour?, ApplicationErrors>()
        let publisher = subject.eraseToAnyPublisher()
        
        publisher
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .tryMap {
                if let hour = $0 {
                    return hour
                }
                
                throw ApplicationErrors.unexpectedResponse
            }
            .extractUnderlyingError()
            .sinkToResult { result in
                switch result {
                case .success(let hour):
                    model?.showCurrentHourCondition(hour: hour)
                case .failure(_):
                    model?.showCurrentHourConditionError()
                }
            }
            .store(in: cancelBag)
        
        subject.send(doGetSunsetCondition(forecastday: forecastday))
    }
    
    private func doGetSunsetCondition(forecastday: Forecastday) -> Hour? {
        var current: Hour? = nil
        let count = forecastday.hour.count
        
        guard let sunset = forecastday.astro?.sunset else {
            return nil
        }
        
        Logger.statistics.debug("sunset \(sunset)")
        
        for (index, h) in forecastday.hour.enumerated() {
            if index + 1 < count {
                let next = forecastday.hour[index + 1]
                
                if sunset >= h.time && sunset <= next.time {
                    current = h
                }
            }
        }
        
        return current
    }
    
    internal func getTomorrowCondition(forecastday: Forecastday) {
        let subject = PassthroughSubject<TomorrowConditionDTO, Never>()
        let publisher = subject.eraseToAnyPublisher()
        
        publisher
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .extractUnderlyingError()
            .sinkToResult { result in
                switch result {
                case .success(let tomorrow):
                    model?.showTomorrow(tomorrow: tomorrow)
                case .failure(_):
                    model?.showTomorrowError()
                }
            }
            .store(in: cancelBag)
        
        subject.send(dogGetTomorrowCondition(forecastday: forecastday))
    }
    
    private func dogGetTomorrowCondition(forecastday: Forecastday) -> TomorrowConditionDTO {
        let minTemp = forecastday.day?.mintempC ?? Constants.ERROR_VALUE
        let maxTemp = forecastday.day?.maxtempC ?? Constants.ERROR_VALUE
        let formatTemperature = NSLocalizedString("min_max_temperature", comment: "")
        
        let minMaxTemperature = String(format: formatTemperature, "\(minTemp)", "\(maxTemp)")
        let formattedDay = DateFormatter.formatWith(date: forecastday.date, format: Constants.DAY_OF_THE_WEEK_DATE_FORMAT)
        
        let tomorrow = TomorrowConditionDTO(
            dayOfTheWeek: formattedDay,
            minMaxTemperature: minMaxTemperature,
            temperature: forecastday.day?.avgtempC ?? Constants.ERROR_VALUE,
            iconCode: forecastday.day?.condition.code ?? Int(Constants.ERROR_VALUE))
        
        Logger.statistics.debug("tomorrow is \(formattedDay) - avg \(forecastday.day?.avgtempC ?? Constants.ERROR_VALUE)")
        
        return tomorrow
    }
}

// MARK: - Helper classes

extension WeatherTypes.Intent {
    struct ExternalData {}
}

