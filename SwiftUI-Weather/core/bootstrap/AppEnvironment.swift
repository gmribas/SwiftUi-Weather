//
//  AppEnvironment.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//
import Combine

struct AppEnvironment {}

extension AppEnvironment {
    
    static func bootstrap() {
        do {
            RestDependencyInjection.register()
            try InteractorDependencyInjection().register()
            
            MainInjection().register()
            WeatherHomeInjection().register()
            HourlyForecastHomeInjection().register()
        } catch {
            fatalError("AppEnvironment bootstrap problem")
        }
    }
}
