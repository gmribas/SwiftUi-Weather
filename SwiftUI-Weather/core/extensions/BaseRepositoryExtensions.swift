//
//  RepositoryExtensions.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

extension  BaseRepository {
    func execute<T: Decodable>(_ endpoint: Endpoint, _ pathToDecode: String? = nil) async -> Result<T?, MyError> where T: Decodable {
        await execute(endpoint: endpoint, pathToDecode: pathToDecode)
    }
}
