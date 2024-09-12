//
//  Pocasie.swift
//  Pocasie
//
//  Created by Palino on 08/04/2022.
//

import Foundation

struct VisualCrossing: Codable {
    let currentConditions: CurrentConditions
    let days: [Days]
    
    struct CurrentConditions: Codable {
        let temp: Double
        let feelslike: Double
        let icon: String
    }
    
    struct Days: Codable {
        let datetimeEpoch: Int
        let temp: Double
        let icon: String

    }
}
