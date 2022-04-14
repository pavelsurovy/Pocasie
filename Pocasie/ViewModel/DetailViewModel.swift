//
//  DetailViewModel.swift
//  Pocasie
//
//  Created by Palino on 14/04/2022.
//

import Foundation

class DetailViewModel: ObservableObject {

    @Published var weatherResult: WeatherMain?

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
                DispatchQueue.main.async {
                    self.weatherResult = json
                }
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
