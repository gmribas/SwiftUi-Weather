//
//  MainView+Build.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import SwiftUI

extension MainView {

    static func build() -> some View {
        guard let model = DependencyInjectionContainer.resolve(.automatic, MainModel.self) else {
            fatalError("No dependency of type MainModel registered!")
        }
        
        guard let intent = DependencyInjectionContainer.resolve(.automatic, MainIntent.self) else {
            fatalError("No dependency of type MainModel registered!")
        }
        
        let container = MVIContainer(
            intent: intent as MainIntentProtocol,
            model: model as MainModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        
        let view = MainView(container: container, isNightChecker: IsNightChecker())
        
        return view
    }
}
