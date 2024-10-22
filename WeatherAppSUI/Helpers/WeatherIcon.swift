//
//  WeatherIcon.swift
//  WeatherAppSUI
//
//  Created by Maksim Zimens on 21.10.2024.
//

import Foundation
struct WeatherIcon {
    static func getWeatherIcon(condition: Int) -> String {
        if (condition < 300) {
            return "🌩"
        } else if (condition < 400) {
            return "🌧"
        } else if (condition < 600) {
            return "☔️"
        } else if (condition < 700) {
            return "☃️"
        } else if (condition < 800) {
            return "🌫"
        } else if (condition == 800) {
            return "☀️"
        } else if (condition <= 804) {
            return "☁️"
        } else {
            return "🤷‍"
        }
    }
}
