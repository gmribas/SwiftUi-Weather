//
//  Helpers.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

extension Result {
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
}
