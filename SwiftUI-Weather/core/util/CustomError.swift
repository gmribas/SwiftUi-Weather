//
//  CustomError.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 18/09/23.
//

struct CustomError: Error {
    let message: String
    
    init(message: String) {
        self.message = message
    }
}
