//
//  NetworkClient.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import Foundation

typealias WeatherCompletion = (Result<WeatherResponse, Error>) -> Void

final class NetworkClient {
    private let urlSession = URLSession.shared
    private var weatherTask: URLSessionTask?
    static let shared = NetworkClient()
    
    func fetchWeather(lat: String, lon: String, completion: @escaping WeatherCompletion) {
        assert(Thread.isMainThread)
        let request = weatherRequest(lat: lat, lon: lon)
        weatherTask = urlSession.object(urlSession: urlSession, for: request) { [weak self] (result: Result<WeatherResponse, Error>) in
            DispatchQueue.main.async {
                guard self != nil else {return}
                switch result {
                case .success(let weather):
                    completion(.success(weather))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func weatherRequest(lat: String, lon: String) -> URLRequest {
        URLRequest.makeHTTPRequest(
            path: "?lat=\(lat)&lon=\(lon)&appid=d57f11ea72a6b9793fee32c98a1568a1&units=metric",
            httpMethod: "get"
        )
    }
}
