//
//  ContentView.swift
//  WeatherApp
//
//  Created by Dulain Jayasumana on 2025-02-07.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State private var showSearchSheet = false
    @State private var fetchErrorMessage: String? = nil
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(
                                    latitude: location.latitude,
                                    longitude: location.longitude
                                )
                                fetchErrorMessage = nil
                            } catch {
                                fetchErrorMessage = "Error fetching weather: \(error.localizedDescription)"
                                print("Error fetching weather: \(error)")
                            }
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
            if let errorMessage = fetchErrorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
        .navigationTitle("Weather App")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSearchSheet.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
        .sheet(isPresented: $showSearchSheet) {
            SearchView { coordinate in
                locationManager.location = coordinate
                Task {
                    do {
                        weather = try await weatherManager.getCurrentWeather(
                            latitude: coordinate.latitude,
                            longitude: coordinate.longitude
                        )
                        fetchErrorMessage = nil
                    } catch {
                        fetchErrorMessage = "Error fetching weather: \(error.localizedDescription)"
                        print("Error fetching weather: \(error)")
                    }
                }
            }
        }
        .onAppear {
            if locationManager.location == nil {
                locationManager.requestLocation()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
