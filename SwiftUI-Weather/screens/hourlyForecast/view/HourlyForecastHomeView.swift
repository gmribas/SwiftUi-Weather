//
//  HourlyForecastHomeView.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import Foundation
import SwiftUI

struct HourlyForecastHomeView: View {
    
    @State internal var errorAlert = false
    
    @State internal var isNightChecker: IsNightChecker
    
    @State internal var forecast: ForecastResponse
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNightChecker.isNight)
            
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(self.forecast.forecast?.forecastday?.first?.hour ?? [Hour](), id: \.timeEpoch) { item in
                        WeatherView(
                            title: DateFormatter.formatWith(date: item.time, format: Constants.DAY_MONTH_YEAR_DATE_FORMAT),
                            bottomText: NSLocalizedString("feels_like", comment: "\(item.feelslikeC)"),
                            titleSize: 12,
                            icon: WeatherIconsByCode.getIconByCode(item.condition.code, forceNight: $isNightChecker.isNight),
                            frameHeight: 170,
                            frameWidht: .infinity,
                            temperature: item.tempC ?? 0,
                            temperatureSize: 20,
                            feelsLikeSize: 25,
                            iconFrame: 50)
                    }
                }
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }
}
