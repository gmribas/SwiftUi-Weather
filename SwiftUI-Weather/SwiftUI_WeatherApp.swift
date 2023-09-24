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
        AppEnvironment.bootstrap()
    }
    
    var body: some Scene {
        WindowGroup {
            WeatherHomeView.build()
        }
    }
}
