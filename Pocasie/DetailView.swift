//
//  DetailView.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import SwiftUI

struct DetailView: View {
    let name: String
    let latitude: Double
    let longitude: Double
    
    var body: some View {
        Text(name)
        Text("\(latitude)")
        Text("\(longitude)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Ružomberok", latitude: 46.0, longitude: 20.1)
    }
}
