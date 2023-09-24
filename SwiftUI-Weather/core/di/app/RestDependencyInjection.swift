//
//  RestDependencyInjection.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

struct RestDependencyInjection {
    
    static func register() {
        let jsonDecoder = jsonDecoderBuilder()
        DependencyInjectionContainer.register(JSONDecoder.self, jsonDecoder)
        DependencyInjectionContainer.register(CurrentWeatherRemoteRepository.self, CurrentWeatherRemoteRepositoryImpl(session: configuredURLSession()))
    }
    
    private static func jsonDecoderBuilder() -> JSONDecoder {
        let diskCapacity = 60 * 1024 * 1024
        let memoryCapacity = 90 * 1024 * 1024
       
       URLSession.shared.configuration.urlCache?.diskCapacity = diskCapacity
       URLSession.shared.configuration.urlCache?.memoryCapacity = memoryCapacity

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.keyDecodingStrategy = decoder.keyDecodingStrategy
        
        return decoder
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
}
