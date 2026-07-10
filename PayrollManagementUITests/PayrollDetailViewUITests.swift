//
//  PayrollDetailViewUITests.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 10/07/26.
//


import XCTest
@testable import PayrollManagement

final class PayrollDetailViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        launchApp(withData: true)
        navigateToPayrollDetail()
    }

    private func launchApp(withData: Bool = false) {

        app = XCUIApplication()

        if withData {
            app.launchArguments = ["UITestingWithData"]
        } else {
            app.launchArguments = ["UITesting"]
        }

        app.launch()
    }

    private func navigateToPayrollDetail() {

        let payrollCard = app.buttons["PayrollSummaryCard"].firstMatch

        XCTAssertTrue(
            payrollCard.waitForExistence(timeout: 3),
            "Payroll card should exist."
        )

        payrollCard.tap()
    }

    func testPayrollDetail_WhenOpened_ShouldShowHeader() {

        XCTAssertTrue(
            app.staticTexts["Payroll Details"]
                .waitForExistence(timeout: 3)
        )
    }

    func testPayrollDetail_WhenOpened_ShouldShowCreatedDateLabel() {

        XCTAssertTrue(
            app.staticTexts["Created at:"]
                .waitForExistence(timeout: 3)
        )
    }

    func testPayrollDetail_WhenOpened_ShouldShowEmployeeNames() {

        XCTAssertTrue(
            app.staticTexts["Vikram"]
                .waitForExistence(timeout: 3)
        )

        XCTAssertTrue(
            app.staticTexts["John"]
                .waitForExistence(timeout: 3)
        )
    }

    func testPayrollDetail_WhenOpened_ShouldShowSummarySection() {

        XCTAssertTrue(app.staticTexts["Total Wages"].exists)
        XCTAssertTrue(app.staticTexts["Total Tax Deducted"].exists)
        XCTAssertTrue(app.staticTexts["Total Net"].exists)
    }

    func testPayrollDetail_WhenBackButtonTapped_ShouldNavigateBack() {

        let backButton = app.buttons["BackButton"]
        
        print(app.debugDescription)

        XCTAssertTrue(backButton.waitForExistence(timeout: 3))

        backButton.tap()

        XCTAssertTrue(
            app.staticTexts["PayrollHubIdentifier"]
                .waitForExistence(timeout: 3)
        )
    }
}
