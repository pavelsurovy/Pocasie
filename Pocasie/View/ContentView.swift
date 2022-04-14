//
//  ContentView.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapView = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.92, longitude: 19.64),
        span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    
    let lokality = [
        Lokality(name: "Bratislava", latitude: 48.1458, longitude: 17.1071),
        Lokality(name: "Banská Štiavnica", latitude: 48.4587, longitude: 18.8931),
        Lokality(name: "Košice", latitude: 48.7203, longitude: 21.2574),
        Lokality(name: "Liptovský Mikuláš", latitude: 49.0822, longitude: 19.6132)
    ]
    
    let iconSize: CGFloat = 30
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapView, annotationItems: lokality) { lokalita in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: lokalita.latitude, longitude: lokalita.longitude)) {
                        NavigationLink {
                            DetailView(lokalita: lokalita)
                        } label: {
                            
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: iconSize, height: iconSize)
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
        .navigationViewStyle(.stack)
        .environment(\.colorScheme, .dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/*
 https://api.openweathermap.org/data/2.5/onecall?lat=48.4585&lon=18.8945&appid=71fbcfd1b59a0d446172d745cd0b359e&exclude=minutely,hourly,alerts&units=metric
*/
