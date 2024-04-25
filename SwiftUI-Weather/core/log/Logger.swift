//
//  ProjectLogger.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 08/10/23.
//

import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    /// All logs related to tracking and analytics.
    private static let statistics = Logger(subsystem: subsystem, category: "statistics")
    
    static func debugLog(_ message: String) {
        statistics.debug("\(message)")
    }
    
    static func errorLog(_ message: String) {
        statistics.error("\(message)")
    }
    
    static func infoLog(_ message: String) {
        statistics.info("\(message)")
    }
}
