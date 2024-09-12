//
//  DetailViewModel.swift
//  Pocasie
//
//  Created by Palino on 14/04/2022.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var weatherResult: VisualCrossing?

    let icon = [
        "snow": "cloud.snow.fill", // snow
        "rain": "cloud.rain.fill", // rain
        "fog": "cloud.fog.fill", // mist / fog
        "wind": "wind", // windy
        "cloudy": "cloud.fill", // clouds
        "partly-cloudy-day": "cloud.sun.fill", // few clouds day
        "partly-cloudy-night": "cloud.moon.fill", // few clouds night
        "clear-day": "sun.max.fill", // clear sky day
        "clear-night": "moon.stars.fill" // clear sky night
    ]

    var svkDescription: String {
        switch weatherResult?.currentConditions.icon {
        case "snow":
            return "Sneženie"
        case "rain":
            return "Dážď"
        case "fog":
            return "Hmla"
        case "wind":
            return "Veterno"
        case "cloudy":
            return "Oblačno"
        case "partly-cloudy-day", "partly-cloudy-night":
            return "Polooblačno"
        default:
            return "Jasno"
        }
    }
    
    func stiahniData(lat: Double, lon: Double) {
        let urlString = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(lat),\(lon)?unitGroup=metric&include=current,days&key=\(APIKey.appID)&contentType=json"

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

            if let json = try? JSONDecoder().decode(VisualCrossing.self, from: data) {
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
