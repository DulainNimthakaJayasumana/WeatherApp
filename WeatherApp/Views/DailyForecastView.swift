//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Dulain Jayasumana on 2025-02-07.
//

import SwiftUI

struct DailyForecastView: View {
    let daily: DailyForecast
    
    var body: some View {
        HStack {
            Text(formattedDay(from: daily.Date))
                .font(.headline)
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            AsyncImage(url: URL(string: "https://developer.accuweather.com/sites/default/files/\(String(format: "%02d", daily.Day.Icon))-s.png")) { image in
                image.resizable().frame(width: 40, height: 40)
            } placeholder: {
                ProgressView()
            }
            
            Spacer()
            
            Text(String(format: "%.0f° / %.0f°", daily.Temperature.Minimum.Value, daily.Temperature.Maximum.Value))
                .font(.subheadline)
                .frame(width: 100, alignment: .trailing)
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
    }
    
    func formattedDay(from dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEEE"
            return dayFormatter.string(from: date)
        }
        return ""
    }
}

struct DailyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        DailyForecastView(daily: previewAccuWeatherData.daily.first!)
    }
}
