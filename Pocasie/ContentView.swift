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
    
    @State private var lokality = [Lokality]()
    
    let iconSize: CGFloat = 30
//    let bratislava = Lokality(name: "Bratislava", coordinates: CLLocationCoordinate2D(latitude: 48.1458923, longitude: 17.1071373))
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapView, annotationItems: lokality) { lokalita in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: lokalita.latitude, longitude: lokalita.longitude)) {
                        NavigationLink {
                            DetailView(name: lokalita.name, latitude: lokalita.latitude, longitude: lokalita.longitude)
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
                
                Button {
                    
                    pridajLokalitu(coordinates: mapView.center)
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                        .foregroundColor(.teal)
                        .opacity(0.4)
                }
                .offset(y: iconSize * 2)
                
            }
            .ignoresSafeArea()
            .onAppear {
//                lokality.append(bratislava)
                resolve()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    func pridajLokalitu(coordinates: CLLocationCoordinate2D) {       
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { placemark, error in
            
            if error != nil {
                print("Error: \(error?.localizedDescription ?? "Unknown Error")")
                return
            }

            guard let firstLocation = placemark?.first else { return }
            
            var displayLocationName = ""
            
            if firstLocation.locality != nil {
                displayLocationName += firstLocation.locality!
            
            } else {
                if firstLocation.subAdministrativeArea != nil {
                    displayLocationName += firstLocation.subAdministrativeArea!
                
                } else {
                    displayLocationName += firstLocation.name ?? "Nowhere"
                }
            }
            
            let newLocation = Lokality(name: displayLocationName, latitude: coordinates.latitude, longitude: coordinates.longitude)
            lokality.append(newLocation)
            
            save()
        }
    }
    
    func resolve() {
        if let data = UserDefaults.standard.data(forKey: "MapLocations") {
            if let decoded = try? JSONDecoder().decode([Lokality].self, from: data) {
                lokality = decoded
            }
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(lokality) {
            UserDefaults.standard.set(encoded, forKey: "MapLocations")
        }
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
