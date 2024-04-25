//
//  MainView.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import Foundation
import SwiftUI

struct MainView: View {
    
    @State internal var errorAlert = false
    
    @StateObject internal var container: MVIContainer<MainIntentProtocol, MainModelStatePotocol>
    
    @ObservedObject internal var isNightChecker: IsNightChecker
    
    private var intent: MainIntentProtocol { container.intent }
    
    private var state: MainModelStatePotocol { container.model }
    
    private let weatherSubjects = RouterSubjects<WeatherRouter.ScreenType, WeatherRouter.RouterAlertType>()
    
    private let hourlySubjects = RouterSubjects<HourlyForecastRouter.ScreenType, HourlyForecastRouter.RouterAlertType>()
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNightChecker.isNight)
            
            VStack {
                switch state.contentState {
                case .loading:
                    ProgressView()
                        .scaleEffect(2.0, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                    
                case .error(let text):
                    LocationAlertView(errorAlert: errorAlert, title: "Error", message: text)
                    
                case .errorAlert(let title, let message):
                    LocationAlertView(errorAlert: errorAlert, title: title, message: message)
            
                case .showForecast(location: let location, currentCondition: let currentCondition, forecast: let forecast):
                    TabView {
                        WeatherRouter(subjects: weatherSubjects)
                            .makeScreen(type: .showHomeWeather(location: location, currentCondition: currentCondition, forecast: forecast))
                            .tabItem {
                                Label("Today", systemImage: "house.fill")
                            }
                        
                        HourlyForecastRouter(subjects: hourlySubjects)
                            .makeScreen(type: .showHourlyForecast(forecast: forecast))
                            .tabItem {
                                Label("Hourly", systemImage: "clock.fill")
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                intent.viewOnAppear()
            }
            .modifier(MainRouter(subjects: state.routerSubject, intent: intent))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
