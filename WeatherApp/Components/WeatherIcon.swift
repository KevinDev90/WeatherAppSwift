//
//  WeatherIcon.swift
//  WeatherApp
//
//  Created by Kevin Guzman on 15/08/23.
//

import SwiftUI

struct WeatherIcon: View {
    var icon: String
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 40))
    }
}

struct WeatherIcon_Previews: PreviewProvider {
    static var previews: some View {
        WeatherIcon(icon: "sun.max")
    }
}
