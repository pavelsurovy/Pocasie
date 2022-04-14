//
//  DetailView.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import SwiftUI

struct DetailView: View {
    var lokalita: Lokality
    
    @State private var weatherResult: WeatherMain?
    
    let icon = [
        "01d": "sun.max.fill", // clear sky
        "02d": "cloud.sun.fill", // few clouds
        "03d": "cloud.fill", // scattered clouds
        "04d": "smoke.fill", // broken clouds
        "09d": "cloud.sun.rain.fill", // shower rain
        "10d": "cloud.heavyrain.fill", // rain
        "11d": "cloud.bolt.fill", // thunderstorm
        "13d": "cloud.snow.fill", // snow
        "50d": "text.aligncenter" // mist
    ]
    
    var svkDescription: String {
        switch weatherResult?.current.weather.first!.main {
        case "Clear":
            return "Jasno"
        case "Clouds":
            return "Oblačno"
        case "Thunderstorm":
            return "Búrka"
        case "Drizzle":
            return "Mrholenie"
        case "Rain":
            return "Dážď"
        case "Snow":
            return "Sneženie"
        default:
            return "..."
        }
    }
    
    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                Text("\(Text(Date.now, format: .dateTime.day().month().year()))")
                    .font(.callout)
                    .padding(.bottom, 20)
                    
                Text(svkDescription)
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
                                .frame(width: 110, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: icon[day.weather.first!.icon] ?? "exclamationmark.square")
                                .symbolRenderingMode(.multicolor)
                                
                            Spacer()
                            
                            Text("\(Int(day.temp.day))°C")
                                .frame(width: 60, alignment: .trailing)
                        }
                        .padding(.bottom, 3)
                        
                        Divider()
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle(lokalita.name)
        .onAppear {
            stiahniData(lat: lokalita.latitude, lon: lokalita.longitude)
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
        let bs = Lokality(name: "Banská Štiavnica", latitude: 48.4587, longitude: 18.8931)
        DetailView(lokalita: bs)
            .preferredColorScheme(.dark)
    }
}