//
//  LocalizableStrings.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 25/10/23.
//

import Foundation

struct LocalizableStrings {
    static func localize(key: String, arguments: CVarArg...) -> String {
         return String(format: NSLocalizedString(key, bundle: .main, comment: ""), arguments)
    }
}
