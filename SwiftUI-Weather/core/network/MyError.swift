//
//  MyError.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

enum MyError: Error {
    case failed(String?)
    case unknown
    case notMapped(String?)
}
