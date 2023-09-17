//
//  CurrentWeatherEndpoint.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation


struct CurrentWeatherEndpoint: Endpoint {
    func url() -> URL {
        return URL(string: Constants.WEATHER_BASE_URL + "/current.json&key=" + Constants.WEATHER_API_KEY)!
    }
    
    func requestType() -> RequestType {
        return .get
    }
    
    func parameters() -> [String : Any]? {
        return nil
    }
    
    func headers() -> [String : Any]? {
        return nil
    }
}
