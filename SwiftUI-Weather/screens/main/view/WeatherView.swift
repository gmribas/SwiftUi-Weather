//
//  WeatherAndTemperatureWidget.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 15/09/23.
//

import Foundation
import SwiftUI

struct WeatherView: View {
    
    let title: String
    let titleSize: CGFloat
    let icon: String
    let temperature: Double
    let temperatureSize: CGFloat
    let iconFrame: CGFloat
    var textFrameW: CGFloat? = nil
    var textFrameH: CGFloat? = nil
    
    var body: some View {
        VStack(alignment: .center) {
            let text = Text(title)
                .font(.system(size: titleSize, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding()
            
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
                title: "FRI",
                titleSize: 12,
                icon: "cloud.sun.rain.fill",
                temperature: Double.random(in: 0..<80),
                temperatureSize: 24,
                iconFrame: 50,
                textFrameW: 80,
                textFrameH: 50
            )
        }
        
    }
}
#endif
