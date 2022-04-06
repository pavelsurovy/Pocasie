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
        
        .task {
            getRemoteData(lat: 40.1, lon: 21.2)
        }
        
    }
    
    func getRemoteData(lat: Double, lon: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&appid=71fbcfd1b59a0d446172d745cd0b359e&exclude=minutely,hourly,alerts&units=metric"
        
        guard let url = URL(string: urlString) else {
            print("urlString problem")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("we have an error")
                return
            }
            
            guard let data = data else {
                print("we dont have data")
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data) {
                print("we have data! \(json)")
            }
            
            print(response)
        }
        
        task.resume()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "haha", miesto: CLLocationCoordinate2D(latitude: 0, longitude: 0))
    }
}
