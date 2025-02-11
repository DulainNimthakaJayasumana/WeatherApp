//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Dulain Jayasumana on 2025-02-07.
//

import SwiftUI

struct HourlyForecastView: View {
    let hourly: HourlyForecast
    
    var body: some View {
        VStack(spacing: 8) {
            Text(formattedTime(from: hourly.DateTime))
                .font(.caption)
                .foregroundColor(.white)
            
            AsyncImage(url: URL(string: "https://developer.accuweather.com/sites/default/files/\(String(format: "%02d", hourly.WeatherIcon))-s.png")) { image in
                image.resizable().frame(width: 40, height: 40)
            } placeholder: {
                ProgressView()
            }
            
            Text("\(hourly.Temperature.Metric.Value, specifier: "%.0f")°")
                .font(.caption)
                .foregroundColor(.white)
        }
        .padding(8)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
    
    func formattedTime(from dateTimeString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateTimeString) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h a"
            return timeFormatter.string(from: date)
        }
        return ""
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        // Dummy preview data can be provided in ModelData.swift
        HourlyForecastView(hourly: previewAccuWeatherData.hourly.first!)
    }
}
