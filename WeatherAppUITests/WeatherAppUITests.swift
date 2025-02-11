//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Dulain Jayasumana on 2025-02-04.
//

import XCTest

final class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Cleanup code can go here, if needed
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Example check: see if the "Welcome to the Weather App" text appears for users without location permissions.
        // This depends on the environment/simulator not having location permission set.
        let welcomeText = app.staticTexts["Welcome to the Weather App"]
        XCTAssertTrue(welcomeText.exists, "Welcome text should appear on launch for first-time location usage.")
    }
    
    @MainActor
    func testTapLocationButton() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Try tapping the location button from the WelcomeView.
        // The button might have an accessibility label like "Share Current Location" or "LocationButton".
        let locationButton = app.otherElements.buttons["Share Current Location"]  // Adjust if needed
        if locationButton.exists {
            locationButton.tap()
            // Normally, if location permission is granted or denied, the UI might change.
            // For example, you could check a loading indicator if isLoading is triggered.
        } else {
            XCTFail("Location button not found.")
        }
    }
    
    // Additional UI test examples...
}
