//
//  ResponseStruct.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let base: String?
    let main: Main
    let visibility: Int?
    let dt: Int?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
    
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case dt
        case timezone
        case id
        case name
        case cod
    }
}

struct Coordinates: Codable {
    let lon: Double?
    let lat: Double?

    enum CodingKeys: String, CodingKey {
        case lon
        case lat
    }
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?

    enum CodingKeys: String, CodingKey {
        case id
        case main
        case description
        case icon
    }
}

struct Main: Codable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let grndLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}
