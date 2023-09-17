//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            
            VStack {
                WeatherView(
                    dayOfWeek: "Cupertino, CA",
                    dayTextSize: 32,
                    icon: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                    temperature: 76,
                    temperatureSize: 70,
                    iconFrame: 180,
                    textFrameW: 250,
                    textFrameH: 50
                )
                
                
                let weatherIconList: [String] = ["cloud.sun.rain.fill", "wind", "cloud.moon.rain.fill", "cloud.moon.bolt.fill", "smoke.fill"]
                
                let weatherList: [WeatherView] = [
                    WeatherView(
                        dayOfWeek: "MON",
                        dayTextSize: 14,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    ),

                    WeatherView(
                        dayOfWeek: "TUE",
                        dayTextSize: 12,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    ),

                    WeatherView(
                        dayOfWeek: "WED",
                        dayTextSize: 12,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    ),

                    WeatherView(
                        dayOfWeek: "THR",
                        dayTextSize: 12,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    ),

                    WeatherView(
                        dayOfWeek: "FRI",
                        dayTextSize: 12,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    )
                ]

                HStack(spacing: 10) {
                    ForEach(weatherList, id: \.dayOfWeek.hashValue) { item in
                        item
                    }
                }
                
                Spacer()
                
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(text: "Change day time", textColor: Color.blue, backgroundColor: Color.white)
                }

                Spacer()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
