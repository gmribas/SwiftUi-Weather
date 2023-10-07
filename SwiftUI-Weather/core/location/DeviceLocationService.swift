//
//  DeviceLocationService.swift
//  SwiftUI-Weather
//
//  Created by Gemerson Ribas on 03/10/23.
//

import Combine
import CoreLocation

class DeviceLocationService: NSObject, CLLocationManagerDelegate, ObservableObject {

    var coordinatesPublisher = PassthroughSubject<CLLocationCoordinate2D, Error>()
    var deniedLocationAccessPublisher = PassthroughSubject<Void, Never>()

    private override init() {
        super.init()
    }
    
    static let shared = DeviceLocationService()

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()

    func requestLocationUpdates() {
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        default:
            deniedLocationAccessPublisher.send()
        }
    }
    
    func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }

    //Overrides CLLocationManagerDelegate
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
            
        default:
            manager.stopUpdatingLocation()
            deniedLocationAccessPublisher.send()
        }
    }

    //Overrides CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coordinatesPublisher.send(location.coordinate)
    }
    
    //Overrides CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        coordinatesPublisher.send(completion: .failure(error))
    }
}
