//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import SwiftUI

struct WeatherHomeView: View {
    
    @State private var isNight = false
    
    @State private var errorAlert = false
    
    @StateObject var container: MVIContainer<WeatherIntentProtocol, WeatherModelStatePotocol>

    private var intent: WeatherIntentProtocol { container.intent }
    private var state: WeatherModelStatePotocol { container.model }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            Spacer().frame(maxHeight: 20)
            
            VStack {
                switch state.contentState {
                case .loading:
                    ProgressView()
                        .scaleEffect(2.0, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                
                case .contentForecast(let location, let condition, let forecast):
                    WeatherView(
                       title: "\(location.name), \(location.region)",
                       titleSize: 32,
                       icon: WeatherIconsByCode.getIconByCode(condition.condition.code, forceNight: isNight),
                       temperature: condition.tempC,
                       temperatureSize: 70,
                       iconFrame: 150,
                       textFrameW: 250,
                       textFrameH: 50
                   )
                    
                    ScrollView {
                        HStack {
                            ForEach(forecast.forecast?.forecastday ?? [Forecastday](), id: \.dateEpoch) { item in
                                let title: String = "\(item.day?.condition.text ?? "EMPTY CONDITION")"
                                
                                WeatherView(
                                   title: title.replacingOccurrences(of: " ", with: "\n"),
                                   titleSize: 15,
                                   icon: WeatherIconsByCode.getIconByCode(condition.condition.code, forceNight: isNight),
                                   temperature: condition.tempC,
                                   temperatureSize: 20,
                                   iconFrame: 35,
                                   textFrameW: 150,
                                   textFrameH: 25
                               )
                                
                                Spacer().frame(maxWidth: 62)
                            }
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                    }
                    
                case .error(let text):
                    Text(text)
                case .errorAlert(let title, let message):
                    Spacer()
                        .alert(isPresented: $errorAlert, content: {
                            Alert(
                                title: Text(title),
                                message: Text(message),
                                dismissButton: .default(Text("OK"), action: { errorAlert = false })
                            )
                        })
                        .onAppear { errorAlert = true }
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
        }
        .onAppear {
            isNight = container.model.checkIfIsNightTime()
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
