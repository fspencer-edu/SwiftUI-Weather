//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Fiona Spencer on 2026-05-26.
//

import SwiftUI

struct WeatherDay {
    let dayOfWeek: String
    let imageName: String
    let temperature: Int
}

let weatherDays = [
    WeatherDay(dayOfWeek: "TUE", imageName: "cloud.sun.fill", temperature: 76),
    WeatherDay(dayOfWeek: "WED", imageName: "sun.max.fill", temperature: 88),
    WeatherDay(dayOfWeek: "THUR", imageName: "cloud.sun.fill", temperature: 76),
    WeatherDay(dayOfWeek: "FRI", imageName: "cloud.sun.fill", temperature: 76),
    WeatherDay(dayOfWeek: "SAT", imageName: "sunset.fill", temperature: 25)
]

struct ContentView: View {
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack {
                CityTextView(cityName: "Cupertino, CA")
                
                MainWeatherStatusView(imageName: "cloud.sun.fill", temperature: 76)
                
                HStack(spacing: 20) {
                    ForEach(weatherDays, id: \.dayOfWeek) { day in
                        WeatherDayView(
                            dayOfWeek: day.dayOfWeek,
                            imageName: day.imageName,
                            temperature: day.temperature
                        )
                    }
                }
                
                Spacer()
                
                Button {
                    isNight.toggle()
                    print(isNight)
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
            }
        }
    }
}
#Preview {
    ContentView()
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}


struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}


struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

