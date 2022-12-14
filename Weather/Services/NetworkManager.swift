//
//  NetworkManager.swift
//  Weather
//
//  Created by Nikolai Maksimov on 12.12.2022.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
        
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping(WeatherData) -> Void) {
        guard let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)&extra=true") else { return }

        var request = URLRequest(url: url)
        request.addValue("3207df6a-3313-40f8-ba3b-b3b5e79ed9f8", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "no description")
                return
            }
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
