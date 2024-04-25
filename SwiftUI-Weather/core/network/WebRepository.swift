//
//  WebRepository.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

import Foundation
import Combine
import OSLog

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
    var jsonDecoder: JSONDecoder { get }
}

extension WebRepository {
    func call<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error>
        where Value: Codable {
        do {
            Logger.infoLog("WebRepository Request \(endpoint.method) \(endpoint.path)")
            
            let request = try endpoint.urlRequest(baseURL: baseURL)
            
            if let cachedResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: request) {
                let httpResponse = cachedResponse.response as? HTTPURLResponse
                return session
                    .dataTaskPublisher(for: request)
                    .publishCache(cacheResponse: httpResponse, jsonDecoder: jsonDecoder)
            }
            
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes, jsonDecoder: jsonDecoder)
        } catch let error {
            Logger.errorLog("WebRepository Error \(error)")
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}

// MARK: - Helpers

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HTTPCodes, jsonDecoder: JSONDecoder) -> AnyPublisher<Data, Error> {
        return tryMap {
            assert(!Thread.isMainThread)
            let data = $0.0
            let statusCode: HTTPURLResponse? = ($0.1 as? HTTPURLResponse? ?? nil)
        
            guard let code = statusCode?.statusCode else {
                throw APIError.unexpectedResponse
            }
            guard httpCodes.contains(code) else {
                throw APIError.httpCode(code)
            }
            
//            rawValueLogger(data: data)
            
            return data
        }
        .extractUnderlyingError()
        .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes, jsonDecoder: JSONDecoder) -> AnyPublisher<Value, Error> where Value: Codable {
        return requestData(httpCodes: httpCodes, jsonDecoder: jsonDecoder)
            .decode(type: Value.self, decoder: jsonDecoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func publishCache<Value>(cacheResponse: HTTPURLResponse?, jsonDecoder: JSONDecoder) -> AnyPublisher<Value, Error> where Value: Codable {
        return tryMap {
            assert(!Thread.isMainThread)
            let data = $0.0
            Logger.debugLog("cached value -> \(data)")
            return try jsonDecoder.decode(Value.self, from: data)
        }
        .extractUnderlyingError()
        .eraseToAnyPublisher()
    }
}


private func rawValueLogger(data: Data) {
    if let string = String(bytes: data, encoding: .utf8) {
        Logger.debugLog("raw value -> \(string)")
        Logger.debugLog("=======================")
        Logger.debugLog("=======================")
    } else {
        Logger.debugLog("not a valid UTF-8 sequence")
    }
}
