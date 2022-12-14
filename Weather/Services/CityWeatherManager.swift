//
//  CityWeatherManager.swift
//  Weather
//
//  Created by Nikolai Maksimov on 12.12.2022.
//

import Foundation
import CoreLocation

final class CityWeatherManager {
    
    static let shared = CityWeatherManager()
    private init() {}
   
    // Массив с названиями городов для отображения списка на главном экране
   private let cities = ["Москва", "Санкт-Петербург", "Сочи", "Казань", "Владимир", "Екатеринбург", "Нижний Новгород", "Архангельск", "Иркутск", "Калининград", "Ярославль", "Тула", "Волгоград", "Владивосток", "Краснодар", "Ростов-на-Дону"]
    
    func getCitiesWeather(completion: @escaping([Weather]) -> Void) {
        
        for city in cities {
            
            getCoordinateFrom(city: city) { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                                
                NetworkManager.shared.fetchWeatherData(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                   
                    completion([Weather(cityName: city, weather: weather)])
                }
            }
        }
    }
    
    func getCityWeather(city: String, completion: @escaping(Weather) -> Void) {
        
            getCoordinateFrom(city: city) { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                                
                NetworkManager.shared.fetchWeatherData(latitude: coordinate.latitude, longitude: coordinate.longitude) { weather in
                   
                    completion(Weather(cityName: city, weather: weather))
            }
        }
    }
    
    private func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> Void) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
}
