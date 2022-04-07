//
//  DetailView.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import CoreLocation
import SwiftUI

struct DetailView: View {
    let name: String
    let coordinates: CLLocationCoordinate2D
    
    var body: some View {
        Text(name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Ružomberok", coordinates: CLLocationCoordinate2D(latitude: 46.0, longitude: 20.1))
    }
}
