//
//  EndpointExtensions.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

extension Endpoint {
    func createHeaders() -> [String: Any] {
        var headers = ["Content-Type": "application/json"]
        if let additionalHeaders = self.headers() {
            for header in additionalHeaders {
                headers[header.key] = header.value as? String
            }
        }
        return headers
    }
}

