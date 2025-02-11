//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Dulain Jayasumana on 2025-02-04.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

    // Example: Testing JSON decoding with WeatherManager
    func testWeatherDecoding() throws {
        // Sample JSON for testing
        let sampleJSON = """
        {
          "coord": { "lon": 10, "lat": 20 },
          "weather": [
            { "id": 800, "main": "Clear", "description": "clear sky", "icon": "01d" }
          ],
          "main": {
            "temp": 25.0,
            "feels_like": 26.0,
            "temp_min": 22.0,
            "temp_max": 28.0,
            "pressure": 1013,
            "humidity": 50
          },
          "name": "Sample City",
          "wind": { "speed": 3.2, "deg": 150 }
        }
        """.data(using: .utf8)!
        
        // Attempt to decode into ResponseBody
        let decoded = try JSONDecoder().decode(ResponseBody.self, from: sampleJSON)
        
        // Check fields
        XCTAssertEqual(decoded.name, "Sample City")
        XCTAssertEqual(decoded.main.temp, 25.0, accuracy: 0.001)
        XCTAssertEqual(decoded.weather.first?.main, "Clear")
        XCTAssertEqual(decoded.wind.speed, 3.2, accuracy: 0.001)
    }
    
    // Example: Testing LocationManager initial states
    func testLocationManagerInitialStates() {
        let locationManager = LocationManager()
        
        // By default, location should be nil
        XCTAssertNil(locationManager.location)
        
        // isLoading should be false initially
        XCTAssertFalse(locationManager.isLoading)
    }
    
    // Example: Testing that requestLocation() changes isLoading
    func testLocationManagerRequestLocation() {
        let locationManager = LocationManager()
        XCTAssertFalse(locationManager.isLoading, "Initially isLoading should be false.")
        
        // Call requestLocation and check isLoading
        locationManager.requestLocation()
        XCTAssertTrue(locationManager.isLoading, "After requesting location, isLoading should be true.")
    }
}
