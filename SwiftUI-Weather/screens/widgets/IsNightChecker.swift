//
//  IsNightChecker.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import Foundation
import Combine
import OSLog

final class IsNightChecker: ObservableObject {
    @Published var isNight = false
    
    private func update(_ isNightTime: Bool) {
        isNight = isNightTime
        self.objectWillChange.send()
    }
    
    func checkIfIsNightTime(forecast: ForecastResponse) {
        Logger.debugLog(" Forecast is day => \(forecast.current.isDay)")
        update(forecast.current.isDay == 0)
    }
}
