//
//  WeatherAndTemperatureWidget.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    
    let dayOfWeek: String
    let dayTextSize: CGFloat
    let icon: String
    let temperature: Int
    let temperatureSize: CGFloat
    let iconFrame: CGFloat
    var textFrameW: CGFloat? = nil
    var textFrameH: CGFloat? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            let text = Text(dayOfWeek)
                .font(.system(size: dayTextSize, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding()
            
            if let w = textFrameW, let h = textFrameH {
                text.frame(width: w, height: h)
            }
         
            VStack {
                Image(systemName: icon)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconFrame, height: iconFrame)
                
                Text("\(temperature) °")
                    .font(.system(size: temperatureSize, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .frame(width: iconFrame)
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
        
            WeatherView(
                dayOfWeek: "FRI",
                dayTextSize: 12,
                icon: "cloud.sun.rain.fill",
                temperature: Int.random(in: 0..<80),
                temperatureSize: 24,
                iconFrame: 50,
                textFrameW: 80,
                textFrameH: 50
            )
        }
        
    }
}
#endif
