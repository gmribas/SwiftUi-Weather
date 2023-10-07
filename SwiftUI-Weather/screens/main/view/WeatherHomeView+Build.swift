//
//  WeatherView+Build.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

import SwiftUI

extension WeatherHomeView {

    static func build() -> some View {
        guard let model = DependencyInjectionContainer.resolve(.automatic, WeatherModel.self) else {
            fatalError("No dependency of type WeatherModel registered!")
        }
        
        guard let intent = DependencyInjectionContainer.resolve(.automatic, WeatherIntent.self) else {
            fatalError("No dependency of type WeatherModel registered!")
        }
        
        let container = MVIContainer(
            intent: intent as WeatherIntentProtocol,
            model: model as WeatherModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        
        let view = WeatherHomeView(container: container, isNightChecker: IsNightChecker())
        
        return view
    }
}
