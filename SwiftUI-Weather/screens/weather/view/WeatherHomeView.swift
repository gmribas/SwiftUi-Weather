//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import SwiftUI
import OSLog

struct WeatherHomeView: View {
    
    @State internal var errorAlert = false
    
    @StateObject internal var container: MVIContainer<WeatherIntentProtocol, WeatherModelStatePotocol>
    
    @State internal var isNightChecker: IsNightChecker
    
    @State internal var location: Location
    
    @State internal var currentCondition: CurrentCondition
    
    @State internal var forecast: ForecastResponse
        
    private var intent: WeatherIntentProtocol { container.intent }
    
    private var state: WeatherModelStatePotocol { container.model }
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNightChecker.isNight)
            
            VStack {
                WeatherView(
                    title: location.name,
                    bottomText: LocalizableStrings.localize(key: "feels_like", arguments: String(format: "%.0f", currentCondition.feelslikeC)),
                    titleSize: 45,
                    icon: WeatherIconsByCode.getIconByCode(currentCondition.condition.code, forceNight: $isNightChecker.isNight),
                    frameHeight: 370,
                    frameWidht: 300,
                    temperature: currentCondition.tempC,
                    temperatureSize: 70,
                    feelsLikeSize: 35,
                    iconFrame: 150,
                    textFrameW: 250,
                    textFrameH: 50
                )
                
                ScrollView(.horizontal, showsIndicators: true) {
                   HStack(spacing: 25) {
                       buildSunsetItem()
                       buildTomorrowItem()
                   }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                .frame(maxWidth: .infinity)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
        }
        .onAppear{
            intent.viewOnAppear(forecast: forecast)
        }
    }
    
    private func buildSunsetItem() -> WeatherSimpleView {
        var title = ""
        var icon = WeatherIconsByCode.DEFAULT_ERROR_ICON
        var temperature = 0.0
        
        switch state.sunsetState {
        case .showSunsetCondition(let hour):
            title = "Sunset"
            icon = WeatherIconsByCode.getIconByCode(hour.condition.code, forceNight: $isNightChecker.isNight)
            temperature = hour.tempC ?? 0
        
        case .showSunsetConditionError :
            title = "Error sunset"
            
        default :
            title = "Error !!!!"
        }
        
        return buildWeatherSimpleView(title: title, icon: icon, temperature: temperature)
    }
    
    private func buildTomorrowItem() -> WeatherSimpleView {
        var title = ""
        var icon = WeatherIconsByCode.DEFAULT_ERROR_ICON
        var temperature = 0.0
        
        switch state.tomorrowState {
        case .showTomorrow(let tomorrow) :
            title = tomorrow.dayOfTheWeek
            icon = WeatherIconsByCode.getIconByCode(tomorrow.iconCode, forceNight: $isNightChecker.isNight)
            temperature = tomorrow.temperature
            
        case .showTomorrowError :
            title = "Error getting tomorrow condition"
            
        default :
            title = "Error !!!!"
        }
        
        return buildWeatherSimpleView(title: title, icon: icon, temperature: temperature)
    }
    
    private func buildWeatherSimpleView(title: String, icon: String, temperature: Double) -> WeatherSimpleView {
        return WeatherSimpleView(
            title: title,
            icon: icon,
            frameHeight: 130,
            frameWidht: 50,
            temperature: temperature,
            temperatureSize: 20,
            iconFrame: 50)
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let location = Location(name: "São Paulo", region: "SP", country: "BR", lat: 0.0, lon: 0.0, tzID: "GMT-3", localtimeEpoch: nil, localtime: "")
        
        let condition = Condition(text: "sunny", icon: "", code: 1000)
        let currentCondition = CurrentCondition(lastUpdatedEpoch: 0, lastUpdated: Date(), tempC: 22.2, tempF: 22.2, isDay: 1, condition: condition, windMph: 0, windKph: 0, windDegree: 0, windDir: "N", pressureMB: 0, pressureIn: 0, precipMm: 0, precipIn: 0, humidity: 0, cloud: 0, feelslikeC: 22.2, feelslikeF: 22.2, visKM: 22.2, visMiles: 0, uv: 10, gustMph: 22.2, gustKph: 22.2)
        
        let hour = Hour(timeEpoch: 0, time: Date(), tempC: 22.2, tempF: 22.2, isDay: 1, condition: condition, windMph: 22.2, windKph: 22.2, windDegree: 2, windDir: "N", pressureMB: 1, pressureIn: 1, precipMm: 1, precipIn: 1, humidity: 1, cloud: 1, feelslikeC: 1, feelslikeF: 22.2, windchillC: 22.2, windchillF: 22.2, heatindexC: 22.2, heatindexF: 22.2, dewpointC: 0, dewpointF: 0, willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0, visKM: 0, visMiles: 0, gustMph: 0, gustKph: 0, uv: 20)
        
        let forecastDay = Forecastday(date: Date(), dateEpoch: 0, day: nil, astro: nil, hour: [hour])
        let forecast = Forecast(forecastday: [forecastDay])
        
        
        WeatherHomeView(
            container: WheatherHomeViewBuilderHelper().buildContainer(),
            isNightChecker: IsNightChecker(),
            location: location,
            currentCondition: currentCondition,
            forecast: ForecastResponse(location: location, current: currentCondition, forecast: forecast, alerts: nil))
    }
}
#endif
