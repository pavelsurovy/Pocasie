//
//  Location.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinates: CLLocationCoordinate2D
}
