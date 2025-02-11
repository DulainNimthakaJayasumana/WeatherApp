//
//  WeatherAppUITestsLaunchTests.swift
//  WeatherAppUITests
//
//  Created by Dulain Jayasumana on 2025-02-04.
//

import XCTest

final class WeatherAppUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        // For UI tests, best to stop at the first failure.
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Optionally, insert steps here to perform after app launch but before taking a screenshot
        // For example, logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
