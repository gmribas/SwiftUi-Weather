//
//  Service.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 16/09/23.
//

import Foundation

@propertyWrapper
struct Inject<T> {
    
    private var dependency: T
    
    private(set) public var  wrappedValue: T {
        get { return self.dependency }
        mutating set { dependency = newValue }
    }
    
    init(_ type: DependencyType, dependency: T) {
        guard let dependency = DependencyInjectionContainer.resolve(type, T.self) else {
            let dependencyName = String(describing: T.self)
            fatalError("No dependency of type \(dependencyName) registered!")
        }

        self.dependency = dependency
    }
}
