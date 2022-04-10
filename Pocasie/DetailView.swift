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
    
    @State private var weatherResult: WeatherMain?
    
    var body: some View {
        Text(name)
        Text("\(latitude)")
        Text("\(longitude)")
        Text("\(weatherResult?.current.temp ?? 0.0)")
        
            .onAppear {
                stiahniData(lat: latitude, lon: longitude)
            }
    }
    
    func stiahniData(lat: Double, lon: Double) {

        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&appid=\(APIKey.appID)&exclude=minutely,hourly,alerts&units=metric"

        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Data Error!")
                return
            }
            
            if let json = try? JSONDecoder().decode(WeatherMain.self, from: data) {
                weatherResult = json
            }
            
        }
        task.resume()
        
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Ružomberok", latitude: 46.0, longitude: 20.1)
    }
}
