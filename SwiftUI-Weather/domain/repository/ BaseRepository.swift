//
//  WeatherRepository.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

protocol  BaseRepository {
    func execute<T: Decodable>(endpoint: Endpoint, pathToDecode: String?) async -> Result<T?, MyError>
}


