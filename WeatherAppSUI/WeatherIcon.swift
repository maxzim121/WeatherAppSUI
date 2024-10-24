//
//  WeatherIcon.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import Foundation

struct WeatherIcon {
    static func getWeatherIcon(condition: Int) -> String {
        switch condition {
        case 0..<300:
            return "🌩"
        case 300..<400:
            return "🌧"
        case 400..<600:
            return "☔️"
        case 600..<700:
            return "☃️"
        case 700..<800:
            return "🌫"
        case 800:
            return "☀️"
        case 801...804:
            return "☁️"
        default:
            return "🤷‍"
        }
    }

}
