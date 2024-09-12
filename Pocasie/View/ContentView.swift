//
//  ContentView.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject private var contentModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $contentModel.mapView, annotationItems: contentModel.lokality) { lokalita in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: lokalita.latitude, longitude: lokalita.longitude)) {
                    NavigationLink {
                        DetailView(lokalita: lokalita)
                    } label: {
                        VStack {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: contentModel.iconSize, height: contentModel.iconSize)
                                .foregroundColor(.red)
                            
                            Text(lokalita.name)
                                .foregroundColor(.primary)
                                .font(.caption)
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
