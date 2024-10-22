//
//  NetworkHelpers.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import Foundation

extension URLRequest {
    static func makeHTTPRequest(
        path: String,
        httpMethod: String,
        baseURL: URL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    ) -> URLRequest {
        var request = URLRequest(url: URL(string: path, relativeTo: baseURL)!)
        request.httpMethod = httpMethod
        return request
    }
}

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

extension URLSession {
    func data(
        for request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask {
            let fulfillCompletion: (Result<Data, Error>) -> Void = { result in
                DispatchQueue.main.async { completion(result) }
            }
            let task = dataTask(with: request, completionHandler: { data, response, error in
                if let data = data,
                   let response = response,
                   let statusCode = (response as? HTTPURLResponse)?.statusCode
                {
                    if 200 ..< 300 ~= statusCode {
                        fulfillCompletion(.success(data))
                    } else {
                        fulfillCompletion(.failure(NetworkError.httpStatusCode(statusCode)))
                    }
                } else if let error = error {
                    fulfillCompletion(.failure(NetworkError.urlRequestError(error)))
                } else {
                    fulfillCompletion(.failure(NetworkError.urlSessionError))
                }
            })
            task.resume()
            return task
        }
    
    func object<T: Codable>(
        urlSession: URLSession,
        for request: URLRequest,
        completion: @escaping  (Result<T, Error>) -> Void) -> URLSessionTask {
            let decoder = JSONDecoder()
            return urlSession.data(for: request) { (result: Result<Data, Error>) in
                let response = result.flatMap { data -> Result<T, Error> in
                    Result { try decoder.decode(T.self, from: data) }
            }
                completion(response)
        }
    }
}
