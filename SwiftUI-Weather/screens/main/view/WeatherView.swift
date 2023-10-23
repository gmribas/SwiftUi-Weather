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
    let frameHeight, frameWidht: CGFloat
    let temperature, feelsLike: Double
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
                
                Text("Feels like \(String(format: "%.0f", feelsLike))°")
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
               alignment: .top)
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
                frameHeight: 400,
                frameWidht: 400,
                temperature: Double.random(in: 0..<80),
                feelsLike: Double.random(in: 0..<80),
                temperatureSize: 24,
                feelsLikeSize: 12,
                iconFrame: 50,
                textFrameW: 80,
                textFrameH: 50
            )
        }
        
    }
}
#endif
