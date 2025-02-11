//
//  SearchView.swift
//  WeatherApp
//
//  Created by Dulain Jayasumana on 2025-02-07.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var query: String = ""
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    /// Completion handler returning a coordinate.
    var onSearch: (CLLocationCoordinate2D) -> Void
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter city name or ZIP code", text: $query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if isLoading {
                    ProgressView()
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    searchLocation(query: query)
                }) {
                    Text("Search")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Search Location")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func searchLocation(query: String) {
        guard !query.isEmpty else {
            errorMessage = "Please enter a valid query."
            return
        }
        isLoading = true
        errorMessage = nil
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(query) { placemarks, error in
            isLoading = false
            if let error = error {
                errorMessage = error.localizedDescription
            } else if let coordinate = placemarks?.first?.location?.coordinate {
                onSearch(coordinate)
                dismiss()
            } else {
                errorMessage = "Location not found."
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView { coordinate in
            print(coordinate)
        }
    }
}
