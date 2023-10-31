//
//  MainViewModel.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import SwiftUI
import Combine
import OSLog

final class MainModel: ObservableObject, MainModelStatePotocol {
    @Published var contentState: MainTypes.Model.ContentState = .loading
    
    let routerSubject = MainRouter.Subjects()
    
    private var alreadyExecuted = false
}

// MARK: - Actions Protocol

extension MainModel: MainModelActionsProtocol {
    
    func dispalyLoading() {
        contentState = .loading
    }
    
    func updateForecast(location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse) {
        contentState = .showForecast(location: location, currentCondition: currentCondition, forecast: forecast)
    }
    
    func dispalyError(_ error: Error) {
        contentState = .error(text: "Fail")
    }
    
    func dispalyLocationDenied() {
        contentState = .errorAlert("Location Update", "Location has been denied")
    }
    
    func dispalyErrorAlert(_ title: String, _ message: String) {
        contentState = .errorAlert(title, message)
    }
    
    func alredyExecuted() -> Bool {
        return alreadyExecuted
    }
    
    func setAsExecuted() {
        alreadyExecuted = true
    }
}

// MARK: - Route Protocol

extension MainModel: MainModelRouterProtocol {
    func noActionForNow() {
        
    }
}

// MARK: - Helper classes

extension MainTypes.Model {
    enum ContentState {
        case loading
        case error(text: String)
        case errorAlert(_ title: String, _ message: String)
        case showForecast(location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse)
    }
}
