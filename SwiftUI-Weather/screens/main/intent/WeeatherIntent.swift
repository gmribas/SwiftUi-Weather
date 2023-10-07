//
//  WeeatherIntent.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI
import Combine
import CoreLocation

struct WeatherIntent {

    // MARK: Model

    private weak var model: WeatherModelActionsProtocol?
    
    private weak var routeModel: WeatherModelRouterProtocol?
    
    // MARK: Interactor

    private var currentWeatherInteractor: CurrentWeatherInteractor
    
    private var forecastInteractor: ForecastWeatherInteractor
    
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
        self.currentWeatherInteractor = currentWeatherInteractor
        self.forecastInteractor = forecastInteractor
    }
}

// MARK: - Public

extension WeatherIntent: WeatherIntentProtocol {
    
    func viewOnAppear() {
        model?.dispalyLoading()
        
        observeCoordinateUpdates()
        
        observeDeniedLocationAccess()
        
        requestLocationUpdates()
    }

//    func onTapUrlContent(id: String) {
//        guard let content = contents.first(where: { $0.id == id }) else { return }
//        routeModel?.routeToVideoPlayer(content: content)
//    }
    
    private func invokeForecast(location: String) {
        forecastInteractor.getForecast(location: location)
            .sinkToResult { result in
                switch result {
                case let .success(result):
                    if let forecastResult = result {
                        DeviceLocationService.shared.stopLocationUpdates()
                        isNightChecker.checkIfIsNightTime(forecast: forecastResult)
                        self.model?.updateForecast(location: forecastResult.location, currentCondition: forecastResult.current, forecast: forecastResult)
                    }
                    
                case let .failure(error):
                    self.model?.dispalyError(error)
                }
            }
            .store(in: cancelBag)
    }
    
    func observeCoordinateUpdates() {
        DeviceLocationService.shared.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
                
                model?.dispalyErrorAlert("Coordinates Publisher", "Handle \(completion) for error and finished subscription.")
            } receiveValue: { coordinates in
                print("COORDINATES \(coordinates)")
                
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
                print("Handle access denied event, possibly with an alert.")
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

extension WeatherTypes.Intent {
    struct ExternalData {}
}

