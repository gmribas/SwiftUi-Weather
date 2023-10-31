//
//  WeatherIntentProtocol.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

protocol WeatherIntentProtocol {
    func viewOnAppear()
    func dispalyLocationDenied()
    func observeDeniedLocationAccess()
    func observeCoordinateUpdates()
    func requestLocationUpdates()
}
