//
//  WeatherAndTemperatureWidget.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import Foundation
import SwiftUI
import OSLog

struct WeatherView: View {
    
    let title, bottomText: String
    let titleSize: CGFloat
    let icon: String
    let frameHeight, frameWidht: CGFloat
    let temperature: CGFloat
    let temperatureSize, feelsLikeSize: CGFloat
    let iconFrame: CGFloat
    var textFrameW: CGFloat? = nil
    var textFrameH: CGFloat? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            let text = Text(title)
                .font(.system(size: titleSize, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding()
                .minimumScaleFactor(0.5)
                .lineLimit(2)
            
            Spacer().frame(minHeight: 15)
            
            if let w = textFrameW, let h = textFrameH {
                text.frame(width: w, height: h)
            }
         
            VStack {
                Image(systemName: icon)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconFrame, height: iconFrame)
                
                Text("\(String(format: "%.0f", temperature))°")
                    .font(.system(size: temperatureSize, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(bottomText)
                    .font(.system(size: feelsLikeSize, weight: .medium))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.5)
                    .lineLimit(2)
            }
        }
        .frame(
               minWidth: 0,
               maxWidth: frameWidht,
               minHeight: 0,
               maxHeight: frameHeight,
               alignment: .top
        )
    }
}

#if DEBUG
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]),
                           startPoint: .top,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        
            VStack {
                WeatherView(
                    title: "FRI",
                    bottomText: LocalizableStrings.localize(key: "feels_like", arguments: String(format: "%.0f",Double.random(in: 0..<80))),
                    titleSize: 12,
                    icon: "cloud.sun.rain.fill",
                    frameHeight: 200,
                    frameWidht: 100,
                    temperature: Double.random(in: 0..<80),
                    temperatureSize: 24,
                    feelsLikeSize: 22,
                    iconFrame: 50,
                    textFrameW: 80,
                    textFrameH: 50
                )
            }
            .background(Color.gray)
        }
        
    }
}
#endif
