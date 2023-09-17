//
//  SwiftUI_WeatherApp.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import SwiftUI

@main
struct SwiftUI_WeatherApp: App {
    
    init() {
        setupDependencyContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    private func setupDependencyContainer() {
        RestDependencyInjection.register()
        
//        ServiceContainer.register(type: ServiceA.self, ServiceA())
//        ServiceContainer.register(type: ServiceB.self, ServiceB())
//        ServiceContainer.register(type: ServiceC.self, ServiceC())
    }
    
}
