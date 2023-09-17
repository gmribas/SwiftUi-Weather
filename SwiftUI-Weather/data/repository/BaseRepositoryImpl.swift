//
//  RepositoryImpl.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

class BaseRepositoryImpl: BaseRepository {
    
    @Inject var decoder: JSONDecoder
    
    init(decoder: JSONDecoder) {
        self._decoder = Inject(.automatic, dependency: decoder)
    }
    
    // Executes the API request with the given endpoint and decodes the response into the specified model type.
    func execute<T: Decodable>(endpoint: Endpoint, pathToDecode: String? = nil) async -> Result<T?, MyError> {
        
        // Creates a URL request with the endpoint's URL and sets the cache policy and request type.
        var urlRequest = URLRequest(url: endpoint.url())
        urlRequest.cachePolicy = .returnCacheDataElseLoad
        urlRequest.httpMethod = endpoint.requestType().rawValue
        
        // If the endpoint has parameters, serializes them to JSON and sets them as the request body.
        if let parameters = endpoint.parameters() {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        }

        // Sets the headers for the request.
        endpoint.createHeaders().forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Checks if there is a cached response for the request.
        if let cachedResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: urlRequest),
            let httpResponse = cachedResponse.response as? HTTPURLResponse {
            // If there is a cached response, decodes the data and returns it as a success result.
            let (data, response) = (cachedResponse.data, httpResponse)
            
            return await decodeResponse(data: data, response: response, pathToDecode: pathToDecode)
        }

        do {
            // Performs the API request and decodes the data from the response into the specified model type.
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            return await decodeResponse(data: data, response: response, pathToDecode: pathToDecode)

        } catch(let error) {
            // If an error occurs, returns it as a failure result.
            return .failure(.failed(error.localizedDescription))
        }
    }
        
    
    // Decodes the data from the API response into the specified model type.
    private func decodeResponse<T: Decodable>(data: Data, response: URLResponse, pathToDecode: String? = nil) async -> Result<T?, MyError> {
        // Checks if the API response status code is within the success range (200-299).
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode)  else {
            return .failure(.unknown)
        }
        
        var model: T?
        do {
            var jsonObject: Any?
            if let pathToDecode = pathToDecode,
               let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any] {
                if let arr = dict[pathToDecode] as? Array<Any> {
                    jsonObject = arr
                } else if let dic = dict[pathToDecode] as? [String: Any] {
                    jsonObject = dic
                }
                
                guard let jsonObject = jsonObject,
                      let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: []) else {
                    return .failure(.notMapped(nil))
                }
                model = try decoder.decode(T.self, from: jsonData)
            } else {
                model = try decoder.decode(T.self, from: data)
            }
            
            return .success(model)
            
        } catch(let error) {
            print(error)
            return .failure(.failed(error.localizedDescription))
        }
    }
}
