//
//  WeeatherIntent.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI
import Combine

struct WeatherIntent {

    // MARK: Model

    private weak var model: WeatherModelActionsProtocol?
    private weak var routeModel: WeatherModelRouterProtocol?
    
    // MARK: Location
    
    @StateObject var deviceLocationService = DeviceLocationService.shared
    
//    @State var tokens: Set<AnyCancellable> = []
    
    @State var coordinates: (lat: Double, lon: Double) = (0, 0)
    
    
    // MARK: Interactor

    private var currentWeatherInteractor: CurrentWeatherInteractor
    
    private var forecastInteractor: ForecastWeatherInteractor
    
    // MARK: Business Data

    private let externalData: WeatherTypes.Intent.ExternalData
    
    private let cancelBag = CancelBag()
    
    // MARK: Life cycle

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
        
        requestLocationUpdates()
        
        observeCoordinateUpdates()
        
        observeDeniedLocationAccess()
        
        // FIXME: get location via GPS
        let location = "Castro,PR,Brazil"
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
                        self.model?.updateForecast(location: forecastResult.location, currentCondition: forecastResult.current, forecast: forecastResult)
                    }
                    
                case let .failure(error):
                    self.model?.dispalyError(error)
                }
            }
            .store(in: cancelBag)
    }
    
    func observeCoordinateUpdates() {
        deviceLocationService.coordinatesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Handle \(completion) for error and finished subscription.")
                model?.dispalyErrorAlert("Coordinates Publisher", "Handle \(completion) for error and finished subscription.")
            } receiveValue: { coordinates in
                self.coordinates = (coordinates.latitude, coordinates.longitude)
            }
            .store(in: cancelBag)
    }

    func observeDeniedLocationAccess() {
        deviceLocationService.deniedLocationAccessPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                print("Handle access denied event, possibly with an alert.")
                model?.dispalyErrorAlert("Location Update", "Location Access Denied")
            }
            .store(in: cancelBag)
    }
    
    func requestLocationUpdates() {
        deviceLocationService.requestLocationUpdates()
    }
    
    func dispalyLocationDenied() {
        model?.dispalyLocationDenied()
    }
}

// MARK: - Helper classes

extension WeatherTypes.Intent {
    struct ExternalData {}
}

