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
    
    func fetchWeather(latitude: String, longitude: String, completion: @escaping WeatherCompletion) {
        assert(Thread.isMainThread)
        let request = weatherRequest(latitude: latitude, longitude: longitude)
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
    
    func weatherRequest(latitude: String, longitude: String) -> URLRequest {
        URLRequest.makeHTTPRequest(
            path: "?lat=\(latitude)&lon=\(longitude)&appid=d57f11ea72a6b9793fee32c98a1568a1&units=metric",
            httpMethod: "get"
        )
    }
}
