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
    
    @Inject var model: WeatherModelStatePotocol
    
    @Inject var isNightChecker: IsNightChecker
}

// MARK: - Navigation Screens

extension WeatherRouter {
    enum ScreenType: RouterScreenProtocol {
        case showHomeWeather

        var routeType: RouterScreenPresentationType {
            switch self {
            case .showHomeWeather:
                return .navigationLink
            }
        }
    }

    @ViewBuilder
    func makeScreen(type: RouterScreenType) -> some View {
        switch type {
        case .showHomeWeather:
//            WeatherHomeView
//                .build(
//                    model: self.model,
//                    intent: self.intent,
//                    isNightChecker: self.isNightChecker,
//                    location: location,
//                    currentCondition: currentCondition,
//                    forecast: forecast
//                )
            Text("")
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
