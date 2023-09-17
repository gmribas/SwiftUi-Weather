//
//  RouterScreenProtocol.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 17/09/23.
//

protocol RouterScreenProtocol: RouterNavigationViewScreenProtocol & RouterNavigationStackScreenProtocol & RouterSheetScreenProtocol {
    var routeType: RouterScreenPresentationType { get }
}

enum RouterScreenPresentationType {
    case sheet
    case fullScreenCover
    case navigationLink

    // To make it work, you have to use NavigationStack
    case navigationDestination
}
