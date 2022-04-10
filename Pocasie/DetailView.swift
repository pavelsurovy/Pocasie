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

        ScrollView {
            VStack(alignment: .leading) {
                Text("\(Text(Date.now, format: .dateTime.day().month().year()))")
                    .font(.callout)
                    .padding(.bottom, 20)
                    
                Text(weatherResult?.current.weather.first?.main ?? "...")
                    .font(.system(size: 35))
                    .padding(.bottom, -30)
                
                Text("\(Int(weatherResult?.current.temp ?? 0))°C")
                    .font(.system(size: 65))
                    .fontWeight(.black)
                
                Text("Pocitová teplota \(Int(weatherResult?.current.feels_like ?? 0))°C")
                    .padding(.bottom, 50)
                    .padding(.top, -40)
                    .foregroundColor(.gray)
                    
                if let day = weatherResult?.daily {
                    ForEach(day, id: \.dt) { day in
                        
                        HStack {
                            Text("\(denTyzdna(day.dt))")
                            
                            Spacer()
                            
                            Text(day.weather.first?.icon ?? "...")
                            
                            Spacer()
                            
                            Text("\(Int(day.temp.day))°C")
                            
                        }
                        
                    }
                }
            }
        }
        .navigationTitle(name)
        .padding(20)
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
    
    func denTyzdna(_ num: Int) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEE")
        let jsonDate = Date(timeIntervalSince1970: TimeInterval(num))
        let dateString = formatter.string(from: jsonDate).capitalized
        
        return dateString
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(name: "Ružomberok", latitude: 46.0, longitude: 20.1)
    }
}
