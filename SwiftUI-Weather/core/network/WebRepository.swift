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
            Logger.statistics.info("WebRepository Request \(endpoint.method) \(endpoint.path)")
            
            let request = try endpoint.urlRequest(baseURL: baseURL)
            
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes, jsonDecoder: jsonDecoder)
        } catch let error {
            Logger.statistics.error("WebRepository Error \(error)")
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


private func rawValueLogger(data: Data) {
    if let string = String(bytes: data, encoding: .utf8) {
        Logger.statistics.debug("raw value -> \(string)")
        Logger.statistics.debug("=======================")
        Logger.statistics.debug("=======================")
    } else {
        Logger.statistics.debug("not a valid UTF-8 sequence")
    }
}
