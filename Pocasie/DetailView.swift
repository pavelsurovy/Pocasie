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
    let miesto: CLLocationCoordinate2D
    
    var body: some View {
        Text(name)
        Text("\(miesto.latitude)")
        Text("\(miesto.longitude)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "haha", miesto: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
}
