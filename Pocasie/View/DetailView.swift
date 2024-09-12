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
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(Date.now, format: .dateTime.day().month().year())")
                            .font(.callout)
                            .padding(.bottom, 20)
                        Text(detailModel.weatherResult?.currentConditions.icon ?? "")
                        Text(detailModel.svkDescription)
                            .font(.system(size: 35))
                            .padding(.bottom, -30)
                        
                        Text("\(Int(detailModel.weatherResult?.currentConditions.temp ?? 0))°C")
                            .font(.system(size: 65))
                            .fontWeight(.black)
                        
                        Text("Pocitová teplota \(Int(detailModel.weatherResult?.currentConditions.feelslike ?? 0))°C")
                                            .padding(.bottom, 50)
                                            .padding(.top, -40)
                                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    
                    if let unwrapObrazok = detailModel.weatherResult?.currentConditions.icon {
                        
                        Image(systemName: detailModel.icon[unwrapObrazok] ?? "exclamationmark.square")
                            .resizable()
                            .symbolRenderingMode(.multicolor)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 80)
                            .padding(.trailing, 20)
                        
                    }
                }
                
                if let day = detailModel.weatherResult?.days {
                    
                    ForEach(day, id: \.datetimeEpoch) { day in
                        
                        HStack {
                            Text("\(detailModel.denTyzdna(day.datetimeEpoch))")
                                .frame(width: 100, alignment: .leading)
                            
                            Spacer()
                            
                            Image(systemName: detailModel.icon[day.icon] ?? "exclamationmark.square")
                                .symbolRenderingMode(.multicolor)
                            
                            Spacer()
                            
                            Text("\(Int(day.temp))°C")
                                .frame(width: 80, alignment: .trailing)
                        }
                        .padding(.bottom, 3)
                        
                        Divider()
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle(lokalita.name)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            detailModel.stiahniData(lat: lokalita.latitude, lon: lokalita.longitude)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let bs = Lokality(name: "Banská Štiavnica", latitude: 48.4587, longitude: 18.8931)
        DetailView(lokalita: bs)
    }
}
