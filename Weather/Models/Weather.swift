//
//  Weather.swift
//  Weather
//
//  Created by Nikolai Maksimov on 12.12.2022.
//

import Foundation

struct Weather {
    let cityName: String
    let weather: WeatherData
    
    var description: String {
        """
Ощущаемая температура: \(weather.fact.feelsLike)ºC
Давление: \(weather.fact.pressureMm) (в мм рт. ст.)
Скорость ветра: \(weather.fact.windSpeed) м/c
Порывы ветра: \(weather.fact.windGust) м/с
Влажность воздуха: \(weather.fact.humidity)%
"""
    }
    
    var condition: String {
        switch weather.fact.condition {
        case "clear":                   return "Ясно"
        case "partly-cloudy":           return "Малооблачно"
        case "cloudy":                  return "Облачно с прояснениями"
        case "overcast":                return "Пасмурно"
        case "drizzle":                 return "Морось"
        case "light-rain":              return "Небольшой дождь"
        case "rain":                    return "Дождь"
        case "moderate-rain":           return "Умеренно сильный дождь"
        case "heavy-rain":              return "Сильный дождь"
        case "continuous-heavy-rain":   return "Длительный сильный дождь"
        case "showers":                 return "Ливень"
        case "wet-snow":                return "Дождь со снегом"
        case "light-snow":              return "Небольшой снег"
        case "snow":                    return "Снег"
        case "snow-showers":            return "Снегопад"
        case "hail":                    return "Град"
        case "thunderstorm":            return "Гроза"
        case "thunderstorm-with-rain":  return "Дождь с грозой"
        case "thunderstorm-with-hail":  return "Гроза с градом"

        default: return "Загрузка..."
        }
    }
}


