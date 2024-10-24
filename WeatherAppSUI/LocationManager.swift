//
//  LocationManager.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol: AnyObject {
    var userLocation: CLLocation? { get set }
}

protocol CurrentLocationProtocol: AnyObject {
    func getCurrentLocation()
}

final class LocationManager: NSObject, ObservableObject {
    
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        setCLManagerDelegate()
    }
    
    private func setCLManagerDelegate() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            getCurrentLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
            break
        }
    }
}

extension LocationManager: LocationManagerProtocol {}

extension LocationManager: CurrentLocationProtocol {
    func getCurrentLocation() {
        guard let location = locationManager.location else { return }
        userLocation = location
    }
}
