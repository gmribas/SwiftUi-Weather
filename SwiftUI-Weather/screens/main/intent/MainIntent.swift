//
//  MainIntent.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import SwiftUI
import Combine
import CoreLocation
import OSLog

struct MainIntent {

    // MARK: Model

    private weak var model: MainModelActionsProtocol?
    
    private weak var routeModel: MainModelRouterProtocol?
    
    // MARK: Interactor

    private var currentWeatherInteractor: CurrentWeatherInteractor
    
    private var forecastInteractor: ForecastWeatherInteractor
    
    // MARK: Business Data

    private let externalData: MainTypes.Intent.ExternalData
    
    private let cancelBag = CancelBag()
    
    // MARK: Life cycle
    
    var isNightChecker = IsNightChecker()

    init(model: MainModelActionsProtocol & MainModelRouterProtocol,
         externalData: MainTypes.Intent.ExternalData,
         currentWeatherInteractor: CurrentWeatherInteractor,
         forecastInteractor: ForecastWeatherInteractor) {
        self.externalData = externalData
        self.model = model
        self.routeModel = model
        self.currentWeatherInteractor = currentWeatherInteractor
        self.forecastInteractor = forecastInteractor
    }
}

// MARK: - Public

extension MainIntent: MainIntentProtocol {
    
    func viewOnAppear() {
        if !(model?.alredyExecuted() ?? false) {
            model?.dispalyLoading()
            
            observeCoordinateUpdates()
            
            observeDeniedLocationAccess()
            
            requestLocationUpdates()
        }
    }
    
    private func invokeForecast(location: String) {
        forecastInteractor.getForecast(location: location)
            .sinkToResult { result in
                switch result {
                case let .success(result):
                    if let forecastResult = result {
                        DeviceLocationService.shared.stopLocationUpdates()
                        isNightChecker.checkIfIsNightTime(forecast: forecastResult)
                        self.model?.updateForecast(location: forecastResult.location, currentCondition: forecastResult.current, forecast: forecastResult)
                        self.model?.setAsExecuted() // avoids calling the api every onAppear()
                    }
                    
                case let .failure(error):
                    Logger.errorLog("WeatherIntent invokeForecast Error \(error)")
                    self.model?.dispalyError(error)
                }
            }
            .store(in: cancelBag)
    }
    
    func observeCoordinateUpdates() {
        DeviceLocationService.shared.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                Logger.errorLog("Handle \(completion.error?.localizedDescription ?? "EMPTY ERROR DESCRIPTION") for error and finished subscription.")
                
                model?.dispalyErrorAlert("Coordinates Publisher", "Handle \(completion) for error and finished subscription.")
            } receiveValue: { coordinates in
                Logger.debugLog("COORDINATES \(coordinates.latitude) , \(coordinates.longitude)")
                
                let lat = coordinates.latitude
                let lon = coordinates.longitude
                
                if (lat != 0.0 && lon != 0.0) {
                    guard let location = "\(lat),\(lon)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                        model?.dispalyErrorAlert("Coordinates Publisher", "Encoding coordinates \(coordinates) got south!")
                        return
                    }
                    
                    invokeForecast(location: location)
                }
            }
            .store(in: cancelBag)
    }

    func observeDeniedLocationAccess() {
        DeviceLocationService.shared.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                Logger.errorLog("Handle access denied event, possibly with an alert.")
                model?.dispalyErrorAlert("Location Update", "Location Access Denied")
            }
            .store(in: cancelBag)
    }
    
    func requestLocationUpdates() {
        DeviceLocationService.shared.requestLocationUpdates()
    }
    
    func dispalyLocationDenied() {
        model?.dispalyLocationDenied()
    }
}

// MARK: - Helper classes

extension MainTypes.Intent {
    struct ExternalData {}
}
