//
//  Location.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import Foundation

struct Lokality: Identifiable, Codable {
    var id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
}
