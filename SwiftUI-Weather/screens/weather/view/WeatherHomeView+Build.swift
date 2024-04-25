//
//  WeatherView+Build.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI

extension WeatherHomeView {

    static func build(isNightChecker: IsNightChecker, location: Location, currentCondition: CurrentCondition, forecast: ForecastResponse) -> WeatherHomeView {
        let view = WeatherHomeView(
            container: WheatherHomeViewBuilderHelper().buildContainer(),
            isNightChecker: isNightChecker,
            location: location,
            currentCondition: currentCondition,
            forecast: forecast
        )
        
        return view
    }
}

struct WheatherHomeViewBuilderHelper {
    @Inject private var intent: WeatherIntentProtocol
    
    @Inject private var model: WeatherModel
    
    func buildContainer() -> MVIContainer<WeatherIntentProtocol, WeatherModelStatePotocol> {
        return MVIContainer(
            intent: intent as WeatherIntentProtocol,
            model: model as WeatherModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
    }
}
