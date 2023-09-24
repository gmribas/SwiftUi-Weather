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
}

// MARK: - Actions Protocol

extension WeatherModel: WeatherModelActionsProtocol {

    func dispalyLoading() {
        contentState = .loading
    }

    func update(condition: CurrentConditionResponse) {
        contentState = .content(condition: condition)
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
        case content(condition: CurrentConditionResponse)
        case error(text: String)
    }
}
