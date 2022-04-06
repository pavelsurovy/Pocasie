//
//  ContentView.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.92, longitude: 19.64),
        span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7))
    
    var mapView = MKMapView()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapRegion, annotationItems: Location.exampleLocations) { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        NavigationLink {
                            DetailView(name: location.name)
                        } label: {
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)

                                Text(location.name)
                                    .foregroundColor(.primary)
                                    .font(.caption)
                            }
                        }
                    }
                }
                
                Image(systemName: "plus.circle")
                    .opacity(0.3)
                    .foregroundColor(.teal)
                    .frame(width: 15, height: 15)
                    .offset(x:0, y: 50)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            createLocation(coordinates: mapRegion.center)
                            
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 44, height: 44)
                                .foregroundColor(.teal)
                                .opacity(0.5)
                                .padding(40)
                                .padding(.bottom, 20)
                        }
                    }
                }
                
            }
            .ignoresSafeArea()
        }
    }
    
    func createLocation(coordinates: CLLocationCoordinate2D) {
        print(coordinates.latitude)
        print(coordinates.longitude)
        
        // get locality name
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)) { placemark, error in
            guard error == nil else {
                print("some error occured")
                return
            }
            
            if let firstLocation = placemark?.first  {
                
                print(firstLocation.locality)

                let newLocation = Location(name: firstLocation.locality ?? "N/A", coordinates: coordinates)
                Location.exampleLocations.append(newLocation)
                
            }
        }
        
        // save location - not yet!
        
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
