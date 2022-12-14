//
//  WeatherData.swift
//  Weather
//
//  Created by Nikolai Maksimov on 12.12.2022.
//

import Foundation

struct WeatherData: Codable {
    let fact: Fact
    let forecasts: [Forecast]
}

struct Forecast: Codable {
    let date: String
    let parts: Parts
}

struct Parts: Codable {
    let day: Day
}

struct Day: Codable {
    let tempMin: Int?
    let tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let windGust: Double
    let icon: String
    let condition: String
    let pressureMm: Int
    let windSpeed: Double
    let windDir: String
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case windGust = "wind_gust"
        case icon
        case condition
        case pressureMm = "pressure_mm"
        case windSpeed = "wind_speed"
        case windDir = "wind_dir"
        case humidity
    }
}
