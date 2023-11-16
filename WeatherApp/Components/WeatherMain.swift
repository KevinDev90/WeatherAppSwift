//
//  WeatherMain.swift
//  WeatherApp
//
//  Created by Kevin Guzman on 15/08/23.
//

import SwiftUI

struct WeatherMain: View {
    var weather: ResponseBody
    var iconWeather: String
    
    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold().font(.title)
                    
                    Text("Today \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 5)
                .padding(.top, 10)
                
                HStack {
                    VStack(spacing: 20) {
                        WeatherIcon(icon: iconWeather)
                        
                        Text(weather.weather[0].main)
                        
                    }
                    .frame(width: 150, alignment: .leading)
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text(weather.main.feelsLike.roundDouble() + "°")
                    .font(.system(size: 100))
                    .fontWeight(.bold)
                    .padding(.trailing)
                }
                .padding(.vertical, 5)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.black.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
            )
            Spacer()
            
        }
        .frame(maxWidth: .infinity)

    }
}

struct WeatherMain_Previews: PreviewProvider {
    static var previews: some View {
        WeatherMain(weather: previewWeather, iconWeather: "sun.max")
    }
}
