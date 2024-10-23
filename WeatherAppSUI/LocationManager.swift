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

final class LocationManager: NSObject, ObservableObject {
    
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        setCLManagerDelegate()
    }
    
    func setCLManagerDelegate() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func currentLocation() {
        guard let location = locationManager.location else { return }
        userLocation = location
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            currentLocation()
        case .denied, .restricted:
            locationManager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
}

extension LocationManager: LocationManagerProtocol {}
