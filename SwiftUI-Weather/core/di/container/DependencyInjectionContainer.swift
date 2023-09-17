//
//  DependencyInjectionContainer.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

final class DependencyInjectionContainer {
    
    private static var factories: [String: () -> Any] = [:]
    
    private static var cache: [String: Any] = [:]
    
    static func register<T: Any>(_ type: T.Type, _ factory: @autoclosure @escaping () -> T) {
        factories[String(describing: type.self)] = factory
    }
    
    static func resolve<T: Any>(_ resolveType: DependencyType = .automatic, _ type: T.Type) -> T? {
        let dependencyName = String(describing: type.self)

        switch resolveType {
        case .singleton:
            if let dependency = cache[dependencyName] as? T {
                return dependency
            } else {
                let dependency = factories[dependencyName]?() as? T

                if let dependency = dependency {
                    cache[dependencyName] = dependency
                }

                return dependency
            }
        case .newSingleton:
            let dependency = factories[dependencyName]?() as? T

            if let dependency = dependency {
                cache[dependencyName] = dependency
            }

            return dependency
        case .automatic:
            fallthrough
        case .new:
            return factories[dependencyName]?() as? T
        }
    }
}
