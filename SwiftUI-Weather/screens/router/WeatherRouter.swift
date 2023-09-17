//
//  WeatherRouter.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI
import Foundation

struct WeatherRouter: RouterProtocol {
    typealias RouterScreenType = ScreenType
    typealias RouterAlertType = AlertScreen

    let subjects: Subjects
    let intent: WeatherIntentProtocol
}

// MARK: - Navigation Screens

extension WeatherRouter {
    enum ScreenType: RouterScreenProtocol {
        case showWeather(condition: CurrentConditionResponse)

        var routeType: RouterScreenPresentationType {
            switch self {
            case .showWeather:
                return .navigationLink
            }
        }
    }

    @ViewBuilder
    func makeScreen(type: RouterScreenType) -> some View {
        switch type {
        case let .showWeather(condition: CurrentConditionResponse):
//            WeatherAndTemperatureView.build()
            // MARK: fixme
            ItemView.build(data: .init(title: title, url: url))
        }
    }

    func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts

extension WeatherRouter {
    enum AlertScreen: RouterAlertScreenProtocol {
        case defaultAlert(title: String, message: String?)
    }

    func makeAlert(type: RouterAlertType) -> Alert {
        switch type {
        case let .defaultAlert(title, message):
            return Alert(title: Text(title),
                         message: message.map { Text($0) },
                         dismissButton: .cancel(Text("Cancel")))
        }
    }
}
