//
//  MVIContainerMock.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 31/10/23.
//

import Foundation

struct MVIContainerMock {
    
    static func mockMainContainer() -> MVIContainer<MainIntentProtocol, MainModelStatePotocol> {
        let model = MockMainModel(contentState: .loading, routerSubject: .init())
        return MVIContainer(
            intent: MockMainIntent() as MainIntentProtocol,
            model: model as MainModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
    }
    
    static func mockWeatherHomeContainer() -> MVIContainer<WeatherIntentProtocol, WeatherModelStatePotocol> {
        let model = MockWeatherModel(sunsetState: .none, tomorrowState: .none, routerSubject: .init())
        return MVIContainer(
            intent: MockWeatherIntent() as WeatherIntentProtocol,
            model: model as WeatherModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
    }
}

private struct MockWeatherIntent: WeatherIntentProtocol {
    func viewOnAppear(forecast: ForecastResponse) {}
    func getSunsetCondition(forecastday: Forecastday) {}
    func getTomorrowCondition(forecastday: Forecastday) {}
    func dispalyLocationDenied() {}
    func observeDeniedLocationAccess() {}
    func observeCoordinateUpdates() {}
    func requestLocationUpdates() {}
}

private class MockWeatherModel: ObservableObject, WeatherModelStatePotocol {
    var today: Forecastday?
    var tomorrow: Forecastday?
    
    var sunsetState: WeatherTypes.Model.SunsetState
    var tomorrowState: WeatherTypes.Model.TomorrowState
    var routerSubject: WeatherRouter.Subjects
    
    init(
        sunsetState: WeatherTypes.Model.SunsetState,
        tomorrowState: WeatherTypes.Model.TomorrowState,
        routerSubject: WeatherRouter.Subjects) {
        self.sunsetState = sunsetState
        self.tomorrowState = tomorrowState
        self.routerSubject = routerSubject
    }
}

private struct MockMainIntent: MainIntentProtocol {
    func viewOnAppear() {}
    func dispalyLocationDenied() {}
    func observeDeniedLocationAccess() {}
    func observeCoordinateUpdates() {}
    func requestLocationUpdates() {}
}

private class MockMainModel: ObservableObject, MainModelStatePotocol {
    var contentState: MainTypes.Model.ContentState
    var routerSubject: MainRouter.Subjects
    
    init(contentState: MainTypes.Model.ContentState, routerSubject: MainRouter.Subjects) {
        self.contentState = contentState
        self.routerSubject = routerSubject
    }
}
