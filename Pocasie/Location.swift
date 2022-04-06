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
    
    static var exampleLocations = [
        Location(name: "Bratislava", coordinates: CLLocationCoordinate2D(latitude: 48.1458923, longitude: 17.1071373)),
        Location(name: "Ziarska Chata", coordinates: CLLocationCoordinate2D(latitude: 49.1648311, longitude: 19.7186683))
    ]
}
