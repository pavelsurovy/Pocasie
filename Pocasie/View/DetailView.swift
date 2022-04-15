//
//  DetailView.swift
//  Pocasie
//
//  Created by Palino on 06/04/2022.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var detailModel = DetailViewModel()
    
    var lokalita: Lokality
    
    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                Text("\(Date.now, format: .dateTime.day().month().year())")
                    .font(.callout)
                    .padding(.bottom, 20)
                    
                Text(detailModel.svkDescription)
                    .font(.system(size: 35))
                    .padding(.bottom, -30)
                
                Text("\(Int(detailModel.weatherResult?.current.temp ?? 0))°C")
                    .font(.system(size: 65))
                    .fontWeight(.black)
                
                Text("Pocitová teplota \(Int(detailModel.weatherResult?.current.feels_like ?? 0))°C")
                    .padding(.bottom, 50)
                    .padding(.top, -40)
                    .foregroundColor(.gray)
                    
                if let day = detailModel.weatherResult?.daily {
                    ForEach(day, id: \.dt) { day in
                        
                        HStack {
                            Text("\(detailModel.denTyzdna(day.dt))")
                                .frame(width: 110, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: detailModel.icon[day.weather.first!.icon] ?? "exclamationmark.square")
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
            detailModel.stiahniData(lat: lokalita.latitude, lon: lokalita.longitude)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let bs = Lokality(name: "Banská Štiavnica", latitude: 48.4587, longitude: 18.8931)
        DetailView(lokalita: bs)
            .preferredColorScheme(.dark)
    }
}
