//
//  WebRepository.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
}

extension WebRepository {
    func call<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error>
        where Value: Codable {
        do {
            print("WebRepository Request \(endpoint.method) \(endpoint.path)")
            
            let request = try endpoint.urlRequest(baseURL: baseURL)
            
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes)
        } catch let error {
            print("WebRepository Error \(error)")
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func performAPICall() async -> Void {
        do {
            let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=4345a3018c9d433caa8190801231609&q=Castro,PR,Brazil&aqi=yes")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let wrapper = try JSONDecoder().decode(CurrentConditionResponse.self, from: data)
            print(wrapper)
        } catch let error {
            print("Error !!!!! \(error)")
        }
    }
}

// MARK: - Helpers

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HTTPCodes) -> AnyPublisher<Data, Error> {
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
            return data
        }
        .extractUnderlyingError()
        .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Codable {
        return requestData(httpCodes: httpCodes)
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
