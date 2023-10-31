//
//  MainIntentProtocol.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/10/23.
//

protocol MainIntentProtocol {
    func viewOnAppear()
    func dispalyLocationDenied()
    func observeDeniedLocationAccess()
    func observeCoordinateUpdates()
    func requestLocationUpdates()
}

