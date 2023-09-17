//
//  CurrentConditionResponse.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

struct CurrentConditionResponse: Codable {
    let location: Location
    let current: CurrentCondition
}
