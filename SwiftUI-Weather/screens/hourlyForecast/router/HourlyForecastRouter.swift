//
//  HourlyForecastRouter.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import SwiftUI
import Foundation

struct HourlyForecastRouter: RouterProtocol {
    typealias RouterScreenType = ScreenType
    typealias RouterAlertType = AlertScreen

    let subjects: Subjects
    
    @Inject var isNightChecker: IsNightChecker
}

// MARK: - Navigation Screens

extension HourlyForecastRouter {
    enum ScreenType: RouterScreenProtocol {
        case showHourlyForecast(forecast: ForecastResponse)

        var routeType: RouterScreenPresentationType {
            switch self {
            case .showHourlyForecast:
                return .navigationLink
            }
        }
    }

    @ViewBuilder
    func makeScreen(type: RouterScreenType) -> some View {
        switch type {
        case .showHourlyForecast(let forecast):
            HourlyForecastHomeView.build(isNightChecker: isNightChecker, forecast: forecast)
        }
    }

    func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts

extension HourlyForecastRouter {
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

