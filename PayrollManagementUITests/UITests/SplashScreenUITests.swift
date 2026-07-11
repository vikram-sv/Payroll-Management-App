//
//  SplashScreenUITests.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 11/07/26.
//

import XCTest

final class SplashScreenUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()
    }

    func testAppLaunch_ShouldNavigateToPayrollList() {

        XCTAssertTrue(
            app.staticTexts["PayrollHubIdentifier"]
                .waitForExistence(timeout: 3)
        )
    }
}
