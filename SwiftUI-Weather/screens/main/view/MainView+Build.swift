//
//  MainView+Build.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import SwiftUI

extension MainView {
    
    static func build(model: MainModel, intent: MainIntent) -> some View {
        let container = MVIContainer(
            intent: intent as MainIntentProtocol,
            model: model as MainModelStatePotocol,
            modelChangePublisher: model.objectWillChange)
        
        let view = MainView(container: container, isNightChecker: IsNightChecker())
        
        return view
    }
}
