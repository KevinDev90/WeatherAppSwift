//
//  MapView.swift
//  WeatherApp
//
//  Created by Kevin Guzman on 16/08/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Binding var weather: ResponseBody
    @Binding var loading: Bool
    
    @StateObject var locationManager = LocationManager()
    
    var weatherManager = WeatherManager()
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var coordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: Binding(
                get: { self.coordinateRegion },
                set: { newRegion in
                    self.coordinateRegion = newRegion
                    self.selectedCoordinate = newRegion.center
                }
            ))
            .onTapGesture {
                loading = true
                if let coordinate = selectedCoordinate {
                    Task {
                        do {
                            weather = try await weatherManager.getCurrentWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            loading = false
                            dismiss()
                        } catch {
                            print("Error: \(error)")
                        }
                    }
                }
            }
            .onAppear {
                // Set initial location
                self.selectedCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        coordinateRegion.span.latitudeDelta *= 0.5
                        coordinateRegion.span.longitudeDelta *= 0.5
                    }) {
                        Image(systemName: "plus")
                            .padding(10)
                            .background(Color.black.opacity(0.5))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .frame(width: 44, height: 44) // Size for both buttons
                    
                    Button(action: {
                        coordinateRegion.span.latitudeDelta /= 0.5
                        coordinateRegion.span.longitudeDelta /= 0.5
                    }) {
                        Image(systemName: "minus")
                            .padding(16)
                            .background(Color.black.opacity(0.5))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .frame(width: 44, height: 44) // Size for both buttons
                    
                    Spacer()
                }
                .padding(.bottom, 20)
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let binding = Binding<ResponseBody>(get: { return previewWeather }, set: { _ in })
        let bindingLoading = Binding<Bool> {
            return false
        } set: { _ in
            
        }
        
        MapView(weather: binding, loading: bindingLoading)
    }
}
