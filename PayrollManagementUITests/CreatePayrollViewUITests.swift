//
//  CreatePayrollViewUITests.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 10/07/26.
//


import XCTest
@testable import PayrollManagement

final class CreatePayrollViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        launchApp()
    }

    private func launchApp() {

        app = XCUIApplication()
        app.launchArguments = ["UITesting"]
        app.launch()

        navigateToCreatePayroll()
    }

    private func navigateToCreatePayroll() {

        let addPayrollButton = app.buttons["Add New Payroll"]

        XCTAssertTrue(
            addPayrollButton.waitForExistence(timeout: 3)
        )

        addPayrollButton.tap()
    }

    func testCreatePayroll_WhenOpened_ShouldShowHeader() {

        XCTAssertTrue(
            app.staticTexts["Create Payroll"]
                .waitForExistence(timeout: 3)
        )
    }

    func testCreatePayroll_WhenNoEmployees_ShouldShowPlaceholder() {

        XCTAssertTrue(
            app.staticTexts["AddEmployeesPlaceHolder"]
                .waitForExistence(timeout: 3)
        )
    }

    func testCreatePayroll_WhenNoEmployees_ShouldShowAddEmployeeButton() {

        XCTAssertTrue(
            app.buttons["Add Employee"]
                .waitForExistence(timeout: 3)
        )
    }

    func testCreatePayroll_WhenAddEmployeeTapped_ShouldOpenAddEmployeeSheet() {

        app.buttons["Add Employee"].tap()

        XCTAssertTrue(
            app.staticTexts["Add Employee"]
                .waitForExistence(timeout: 3)
        )
    }
}
