//
//  RestDependencyInjection.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

final class RestDependencyInjection {
    
    static func register() {
        let jsonDecoder = jsonDecoderBuilder()
        DependencyInjectionContainer.register(JSONDecoder.self, jsonDecoder)
        DependencyInjectionContainer.register(BaseRepository.self, BaseRepositoryImpl(decoder: jsonDecoder) )
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
}
