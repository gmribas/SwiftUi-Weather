//
//  ApplicationErrors.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 20/11/23.
//

import Foundation

enum ApplicationErrors: Swift.Error {
    case unexpectedResponse
}

extension ApplicationErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unexpectedResponse: return "Unexpected response"
        }
    }
}
