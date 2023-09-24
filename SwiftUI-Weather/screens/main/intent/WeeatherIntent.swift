//
//  WeeatherIntent.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI

struct WeatherIntent {

    // MARK: Model

    private weak var model: WeatherModelActionsProtocol?
    private weak var routeModel: WeatherModelRouterProtocol?
    
    // MARK: Interactor

    private var interactor: CurrentWeatherInteractor
    
    // MARK: Business Data

    private let externalData: WeatherTypes.Intent.ExternalData
    
    private let cancelBag = CancelBag()
    
    // MARK: Life cycle

    init(model: WeatherModelActionsProtocol & WeatherModelRouterProtocol,
         externalData: WeatherTypes.Intent.ExternalData,
         interactor: CurrentWeatherInteractor) {
        self.externalData = externalData
        self.model = model
        self.routeModel = model
        self.interactor = interactor
    }
}

// MARK: - Public

extension WeatherIntent: WeatherIntentProtocol {

    func viewOnAppear() {
        model?.dispalyLoading()
        
        // FIXME: get location via GPS
        interactor.getCurrentWeather(location: "Castro,PR,Brazil")
            .sinkToResult { result in
                
                // FIXME: define its value
//                fetchCompletion(result.isSuccess ? .newData : .failed)
                
                switch result {
                case let .success(result):
                    if let conditionResult = result {
                        self.model?.update(condition: conditionResult)
                    }
                    
                case let .failure(error):
                    self.model?.dispalyError(error)
                }
            }
            .store(in: cancelBag)
    }

//    func onTapUrlContent(id: String) {
//        guard let content = contents.first(where: { $0.id == id }) else { return }
//        routeModel?.routeToVideoPlayer(content: content)
//    }
}

// MARK: - Helper classes

extension WeatherTypes.Intent {
    struct ExternalData {}
}

