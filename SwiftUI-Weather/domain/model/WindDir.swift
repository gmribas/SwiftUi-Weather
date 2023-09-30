//
//  WindDir.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 28/09/23.
//

enum WindDir: String, Codable {
    case N  = "N" //(North)
    case NNE = "NNE" //(North-Northeast)
    case NE = "NE" //(Northeast)
    case ENE = "ENE" //(East-Northeast)
    case E = "E" //(East)
    case ESE = "ESE" //(East-Southeast)
    case SE = "SE" //(Southeast)
    case SSE = "SSE" //(South-Southeast)
    case S = "S" //(South)
    case SSW = "SSW" //(South-Southwest)
    case SW = "SW" //(Southwest)
    case SWS = "SWS" //(West-Southwest)
    case W = "W" //(West)
    case WNW = "WNW" //(West-Northwest)
    case NW = "NW" //(Northwest)
    case NNW = "NNW" //(North-Northwest)
}
