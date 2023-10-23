//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import SwiftUI

struct WeatherHomeView: View {
        
    @State internal var errorAlert = false
    
    @StateObject internal var container: MVIContainer<WeatherIntentProtocol, WeatherModelStatePotocol>
    
    @ObservedObject internal var isNightChecker: IsNightChecker
    
    private var intent: WeatherIntentProtocol { container.intent }
    
    private var state: WeatherModelStatePotocol { container.model }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNightChecker.isNight)
            
            VStack {
                switch state.contentState {
                case .loading:
                    ProgressView()
                        .scaleEffect(2.0, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                
                case .contentForecast(let location, let condition, let forecastResponse):
                    WeatherView(
                       title: "\(location.name)",
                       titleSize: 45,
                       icon: WeatherIconsByCode.getIconByCode(condition.condition.code, forceNight: $isNightChecker.isNight),
                       frameHeight: 350,
                       frameWidht: 300,
                       temperature: condition.tempC,
                       feelsLike: condition.feelslikeC,
                       temperatureSize: 70,
                       feelsLikeSize: 35,
                       iconFrame: 150,
                       textFrameW: 250,
                       textFrameH: 50
                   )
                    
                    let hStackHeight: CGFloat = 180
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 15) {
                            ForEach(forecastResponse.forecast?.forecastday?.first?.hour ?? [Hour](), id: \.timeEpoch) { item in
                                WeatherView(
                                    title: item.time,
                                    titleSize: 12,
                                    icon: WeatherIconsByCode.getIconByCode(item.condition.code, forceNight: $isNightChecker.isNight),
                                    frameHeight: 100,
                                    frameWidht: hStackHeight,
                                    temperature: item.tempC,
                                    feelsLike: item.feelslikeC,
                                    temperatureSize: 20,
                                    feelsLikeSize: 25,
                                    iconFrame: 50)
                            }
                        }
                        .frame(height: hStackHeight)
                    }
                    

                case .error(let text):
                    Text(text)
                case .errorAlert(let title, let message):
                    LocationAlertView(errorAlert: $errorAlert, title: title, message: message)
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top

            )
        }
        .onAppear {
            intent.viewOnAppear()
        }
        .modifier(WeatherRouter(subjects: state.routerSubject, intent: intent))
    }
}

#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherHomeView(container: MVIContainer<WeatherIntentProtocol, WeatherModelStatePotocol>(intent: <#WeatherIntentProtocol#>(), model: <#WeatherModelStatePotocol#>(), modelChangePublisher: <#ObservableObjectPublisher#>()))
//    }
//}
#endif
