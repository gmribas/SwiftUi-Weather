//
//  HourlyForecastIntent.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import SwiftUI
import Combine
import CoreLocation
import OSLog

struct HourlyForecastIntent {

    // MARK: Model

    private weak var model: HourlyForecastActionsProtocol?
    
    private weak var routeModel: HourlyForecastRouterProtocol?
    
    // MARK: Interactor
    private var forecastInteractor: ForecastWeatherInteractor
    
    // MARK: Business Data
    private let externalData: HourlyForecastTypes.Intent.ExternalData
    
    private let cancelBag = CancelBag()

    init(model: HourlyForecastActionsProtocol & HourlyForecastRouterProtocol,
         externalData: HourlyForecastTypes.Intent.ExternalData,
         forecastInteractor: ForecastWeatherInteractor) {
        self.externalData = externalData
        self.model = model
        self.routeModel = model
        self.forecastInteractor = forecastInteractor
    }
}

// MARK: - Public

extension HourlyForecastIntent: HourlyForecastIntentProtocol {
    
    func viewOnAppear() {
        model?.dispalyLoading()
    }
    
    private func invokeForecast(location: String) {
        forecastInteractor.getForecast(location: location)
            .sinkToResult { result in
                switch result {
                case let .success(result):
                    if let forecastResult = result {
                        self.model?.updateForecast(forecast: forecastResult)
                    }
                    
                case let .failure(error):
                    Logger.errorLog("HourlyForecastIntent invokeForecast Error \(error)")
                    self.model?.dispalyError(error)
                }
            }
            .store(in: cancelBag)
    }
}

// MARK: - Helper classes

extension HourlyForecastTypes.Intent {
    struct ExternalData {}
}
