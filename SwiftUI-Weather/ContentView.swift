//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, Color("lightBlue")]),
                           startPoint: .top,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                WeatherAndTemperatureView(
                    dayOfWeek: "Cupertino, CA",
                    dayTextSize: 32,
                    icon: "cloud.sun.fill",
                    temperature: 76,
                    temperatureSize: 70,
                    iconFrame: 180)
                
                
                let weatherIconList: [String] = ["cloud.sun.rain.fill", "wind", "cloud.moon.rain.fill", "cloud.moon.bolt", "smoke.fill"]
                
                let weatherList: [WeatherAndTemperatureView] = [
                    WeatherAndTemperatureView(
                        dayOfWeek: "MON",
                        dayTextSize: 14,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    ),

                    WeatherAndTemperatureView(
                        dayOfWeek: "TUE",
                        dayTextSize: 12,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    ),

                    WeatherAndTemperatureView(
                        dayOfWeek: "WED",
                        dayTextSize: 12,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    ),

                    WeatherAndTemperatureView(
                        dayOfWeek: "THR",
                        dayTextSize: 12,
                        icon: weatherIconList[Int.random(in: 0..<weatherIconList.count)],
                        temperature: Int.random(in: 0..<80),
                        temperatureSize: 24,
                        iconFrame: 50,
                        textFrameW: 80,
                        textFrameH: 50
                    ),

                    WeatherAndTemperatureView(
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
                    ForEach(weatherList, id: \.temperature) { item in
                        item
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
