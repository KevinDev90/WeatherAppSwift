//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Kevin Guzman on 15/08/23.
//

import SwiftUI

struct WeatherView: View {
    @State var weather: ResponseBody = previewWeather
    @State var loading: Bool = false
    
    @State private var colorBackgroundWeather: Color = Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
    @State private var iconWeather: String = "sun.max"
    @State private var imageWeather: String = "sun"
    @State private var isShowingMap = false
    
    
    var body: some View {
        if !loading {
            ZStack(alignment: .leading) {
                VStack {
                    VStack{
                        Button(action: {
                            isShowingMap = true
                            
                        }) {
                            Image(systemName: "map.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                                .cornerRadius(10)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.bottom, 15)
                    
                    VStack {
                        WeatherMain(weather: weather, iconWeather: iconWeather)
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                WeatherInfo(weather: weather)
                
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(
                Image(imageWeather)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            .preferredColorScheme(.dark)
            .onAppear {
                getWeatherIcon()
            }
            .sheet(isPresented: $isShowingMap, onDismiss: {
                getWeatherIcon()
                loading = false
            }) {
                MapView(weather: $weather, loading: $loading)
            }
        } else {
            VStack {
                LoadingView()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        }
        
    }
    
    private func getWeatherIcon() {
        switch weather.weather[0].main {
        case "Clear":
            iconWeather = "sun.min"
            
        case "Clouds":
            iconWeather = "cloud"
            imageWeather = "clouds"
            
        case "Rain":
            iconWeather = "cloud.rain"
            imageWeather = "rain"
            
        case "Drizzle":
            iconWeather = "cloud.drizzle"
            imageWeather = "drizzle"
            
        case "Thunderstorm":
            iconWeather = "cloud.heavyrain.fill"
            imageWeather = "thunderstorm"
            
        case "Snow":
            iconWeather = "cloud.snow"
            imageWeather = "snow"
            
        case "Tornado":
            iconWeather = "tornado"
            imageWeather = "tornado"
            
        default:
            break
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
