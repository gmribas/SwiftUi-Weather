//
//  WeatherSimpleView.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 24/04/24.
//

import Foundation
import SwiftUI

struct WeatherSimpleView: View {
    let title: String
    let icon: String
    let frameHeight, frameWidht: CGFloat
    let temperature: CGFloat
    let temperatureSize: CGFloat
    let iconFrame: CGFloat
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 12, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding()
                .lineLimit(2)
                .fixedSize(horizontal: true, vertical: true)
            
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
struct WeatherSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]),
                           startPoint: .top,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
        
            VStack {
                WeatherSimpleView(
                    title: "10am",
                    icon: "cloud.sun.rain.fill",
                    frameHeight: 200,
                    frameWidht: 100,
                    temperature: Double.random(in: 0..<80),
                    temperatureSize: 24,
                    iconFrame: 50
                )
            }
            .background(Color.gray)
        }
        
    }
}
#endif
