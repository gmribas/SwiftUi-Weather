//
//  SwiftUI_WeatherApp.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import SwiftUI

@main
struct SwiftUI_WeatherApp: App {
        
    @State
    private var subjects = RouterSubjects<MainRouter.RouterScreenType, MainRouter.RouterAlertType>()
    
    private var intent: MainIntent
    
    init() {
        AppEnvironment.bootstrap()
        
        //@Inject fires before this init, therefore leading to "no dependency registered"
        guard let mainIntent = DependencyInjectionContainer.resolve(.automatic, MainIntent.self) else {
            fatalError("No dependency of type MainIntent registered!")
        }
        
        self.intent = mainIntent
    }
    
    var body: some Scene {
        WindowGroup {
            MainRouter(
                subjects: self.subjects,
                intent: self.intent)
            .makeScreen(type: MainRouter.RouterScreenType.showMainWindow)
        }
    }
}
