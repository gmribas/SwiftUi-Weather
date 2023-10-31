//
//  HourlyForecastHomeView+Build.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

import SwiftUI

extension HourlyForecastHomeView {

    static func build(isNightChecker: IsNightChecker, forecast: ForecastResponse) -> some View {
        return HourlyForecastHomeView(isNightChecker: Binding.constant(isNightChecker), forecast: Binding.constant(forecast))
    }
}
