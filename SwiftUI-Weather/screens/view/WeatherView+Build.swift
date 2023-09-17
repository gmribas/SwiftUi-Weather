//
//  WeatherView+Build.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI

extension WeatherView {

    static func build(condition: CurrentConditionResponse) -> some View {
        let model = WeatherModel()
        let intent = WeatherIntent(model: model, externalData: condition)
        let container = MVIContainer(
            intent: intent as WeatherIntentProtocol,
            model: model as WeatherModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        let view = WeatherView(container: container)
        return view
    }
}
