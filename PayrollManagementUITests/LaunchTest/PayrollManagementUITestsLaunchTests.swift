//
//  PayrollManagementUITestsLaunchTests.swift
//  PayrollManagementUITests
//
//  Created by Vikram Sukumaran on 10/07/26.
//

import XCTest

final class PayrollManagementUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue( app.staticTexts["PayrollHubIdentifier"].waitForExistence(timeout: 5)
        )
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
