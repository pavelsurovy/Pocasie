//
//  ContentViewModel.swift
//  Pocasie
//
//  Created by Palino on 14/04/2022.
//

import Foundation
import MapKit
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var mapView = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.92, longitude: 19.64),
        span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    
    let lokality = [
        Lokality(name: "Bratislava", latitude: 48.1458, longitude: 17.1071),
        Lokality(name: "Banská Štiavnica", latitude: 48.4587, longitude: 18.8931),
        Lokality(name: "Košice", latitude: 48.7203, longitude: 21.2574),
        Lokality(name: "Liptovský Mikuláš", latitude: 49.0822, longitude: 19.6132)
    ]
    
    let iconSize: CGFloat = 30
    
}
