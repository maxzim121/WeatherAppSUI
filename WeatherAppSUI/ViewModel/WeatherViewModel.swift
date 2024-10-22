//
//  WeatherViewModel.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private var networkClient: NetworkClient
    @Published var weatherData: WeatherResponse?
    @ObservedObject var locationManager: LocationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    @Published var isLoading = true
    @Published var failed = false
    
    // MARK: - Initializer
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
        observLocationChanges()
    }
    
    // MARK: - Location Change Observer
    func observLocationChanges() {
        locationManager.$userLocation
            .sink { [weak self] location in
                self?.getCurrentLocationWeather(location)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Getters
    var temp: Int {
        Int(weatherData?.main.temp ?? 0.0)
    }
    
    var name: String {
        "\(weatherData?.name ?? "")"
    }
    
    var conditionId: Int {
        weatherData?.weather.first?.id ?? 0
    }
}

//MARK: - API CALLS

extension WeatherViewModel {
    func getCurrentLocationWeather(_ location: CLLocation?) {
        guard let userLocation = location else  {return}
        self.isLoading = true
        let latitude = String(userLocation.coordinate.latitude)
        let longitude = String(userLocation.coordinate.longitude)
        
        networkClient.fetchWeather(lat: latitude, lon: longitude) { [weak self] result in
            guard let self = self else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.weatherData = nil
                }
                return
            }
            switch result {
            case .success(let weather):
                print("OK")
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.weatherData = weather
                }
            case .failure(let error):
                print(error)
                failed = true
            }
        }
    }
    
    func tryAgainButtonTapped() {
        observLocationChanges()
    }
}
