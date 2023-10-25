//
//  RestDependencyInjection.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

struct RestDependencyInjection {
    
    static func register() {
        urlSessionConfig()
        
        let jsonDecoder = jsonDecoderBuilder()
        let queue = DispatchQueue(label: "bg_parse_queue")
        let session = configuredURLSession()
        
        DependencyInjectionContainer.register(JSONDecoder.self, jsonDecoder)
        DependencyInjectionContainer.register(DispatchQueue.self, queue)
        DependencyInjectionContainer.register(URLSession.self, session)
        
        DependencyInjectionContainer.register(CurrentWeatherRemoteRepository.self, CurrentWeatherRemoteRepositoryImpl(session: session, bgQueue: queue, jsonDecoder: jsonDecoder))
        DependencyInjectionContainer.register(ForecastWeatherRemoteRepository.self, ForecastWeatherRemoteRepositoryImpl(session: session, bgQueue: queue, jsonDecoder: jsonDecoder))
    }
    
    private static func urlSessionConfig() {
        let diskCapacity = 60 * 1024 * 1024
        let memoryCapacity = 90 * 1024 * 1024
       
        URLSession.shared.configuration.urlCache?.diskCapacity = diskCapacity
        URLSession.shared.configuration.urlCache?.memoryCapacity = memoryCapacity
    }
    
    private static func jsonDecoderBuilder() -> JSONDecoder {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        decoder.keyDecodingStrategy = decoder.keyDecodingStrategy
        decoder.dateDecodingStrategy = .iso8601yyyyMMdd
        
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
