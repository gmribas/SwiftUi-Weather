//
//  WeeatherIntent.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI

class WeatherIntent {

    // MARK: Model

    private weak var model: WeatherModelActionsProtocol?
    private weak var routeModel: WeatherModelRouterProtocol?

    // MARK: Services

    private let urlService: WWDCUrlServiceProtocol

    // MARK: Business Data

    private let externalData: WeatherTypes.Intent.ExternalData
    private var condition: CurrentConditionResponse?

    // MARK: Life cycle

    init(model: WeatherModelActionsProtocol & WeatherModelRouterProtocol,
         externalData: WeatherTypes.Intent.ExternalData,
         urlService: WWDCUrlServiceProtocol) {
        self.externalData = externalData
        self.model = model
        self.routeModel = model
        self.urlService = urlService
    }
}

// MARK: - Public

extension WeatherIntent: WeatherIntentProtocol {

    func viewOnAppear() {
        model?.dispalyLoading()

        urlService.fetch(contnet: .swiftUI) { [weak self] result in
            switch result {
            case let .success(contents):
                self?.contents = contents
                self?.model?.update(contents: contents)

            case let .failure(error):
                self?.model?.dispalyError(error)
            }
        }
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

