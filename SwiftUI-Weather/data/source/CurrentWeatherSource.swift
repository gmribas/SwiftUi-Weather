//
//  CurrentWeatherSource.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

protocol CurrentWeatherSource {
    
    func getCurrentWeather(location: String) -> Result<CurrentConditionResponse?, MyError>
}
