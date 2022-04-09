//
//  Pocasie.swift
//  Pocasie
//
//  Created by Palino on 08/04/2022.
//

import Foundation

struct WeatherMain: Codable {
    let lat: Double
    let lon: Double
    let current: WeatherCurrent
    let daily: [WeatherDaily]
    
    struct WeatherCurrent: Codable {
        let temp: Double
        let feels_like: Double
        let weather: [WeatherDescription]
        
        struct WeatherDescription: Codable {
            let main: String
            let icon: String
        }
    }
    
    struct WeatherDaily: Codable {
        let dt: Int
        let temp: DailyTemp
        let weather: [DailyDescription]
        
        struct DailyTemp: Codable {
            let day: Double
        }
        
        struct DailyDescription: Codable {
            let main: String
            let icon: String
        }
    }
}
