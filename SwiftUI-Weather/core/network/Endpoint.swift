//
//  Endpoint.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

protocol Endpoint {
    func url() -> URL
    func requestType() -> RequestType
    func parameters() -> [String: Any]?
    func headers() -> [String: Any]?
}
