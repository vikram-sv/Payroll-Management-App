//
//  PayrollListViewUITests.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 10/07/26.
//


import XCTest

final class PayrollListViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        launchApp()
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

    func testPayrollList_WhenAppLaunches_ShouldShowHeader() {
        XCTAssertTrue(
            app.staticTexts["PayrollHubIdentifier"].exists
        )
    }

    func testPayrolllist_whenNoPayrolls_ShouldShowPlaceholder() {
        XCTAssertTrue(
            app.staticTexts["AddNewPayrollPlaceholder"]
                .waitForExistence(timeout: 3)
        )
    }

    func testPayrollList_WhenNoPayrolls_ShouldShowAddPayrollButton() {
        XCTAssertTrue(
            app.buttons["Add New Payroll"].exists
        )
    }

    func testPayrollList_whenNoPayrolls_AddPayrollButton_ShouldNavigateToPayrollCreation() {

        let addPayrollButton = app.buttons["Add New Payroll"]

        XCTAssertTrue(addPayrollButton.exists)

        addPayrollButton.tap()

        XCTAssertTrue(
            app.staticTexts["Create Payroll"]
                .waitForExistence(timeout: 3)
        )
    }

    func testPayrollList_WhenPayrollExists_ShouldNotShowPlaceholder() {

        app.terminate()
        launchApp(withData: true)

        XCTAssertFalse(
            app.staticTexts["AddNewPayrollPlaceholder"].exists
        )
    }

    func testPayrollList_WhenPayrollExists_ShouldShowCreatePayrollButton() {

        app.terminate()
        launchApp(withData: true)

        XCTAssertTrue(
            app.buttons["CreatePayrollButton"]
                .waitForExistence(timeout: 3)
        )
    }

    func testPayrollList_WhenPayrollExists_ShouldShowPayrollCard() {

        app.terminate()
        launchApp(withData: true)

        XCTAssertTrue(
            app.buttons["PayrollSummaryCard"]
                .waitForExistence(timeout: 3)
        )
    }

    func testPayrollList_WhenPayrollTapped_ShouldNavigateToPayrollDetail() {

        app.terminate()
        launchApp(withData: true)

        app.buttons["PayrollSummaryCard"].firstMatch.tap()
        
        print(app.debugDescription)

        XCTAssertTrue(
            app.staticTexts["PayrollDetailsHeader"]
                .waitForExistence(timeout: 3)
        )
    }
    
    func testPayrollList_WhenEditButtonTapped_ShouldOpenEditPayroll() {

        app.terminate()
        launchApp(withData: true)

        let editButton = app.buttons["EditPayrollButton"].firstMatch

        XCTAssertTrue(editButton.waitForExistence(timeout: 3))

        editButton.tap()

        XCTAssertTrue(
            app.staticTexts["Edit Payroll"]
                .waitForExistence(timeout: 3)
        )
    }
    
    func testPayrollList_WhenDeleteButtonTapped_ShouldShowDeleteConfirmation() {

        app.terminate()
        launchApp(withData: true)

        let deleteButton = app.buttons["DeletePayrollButton"].firstMatch

        XCTAssertTrue(deleteButton.waitForExistence(timeout: 3))

        deleteButton.tap()

        XCTAssertTrue(
            app.staticTexts["Delete Payroll"]
                .waitForExistence(timeout: 3)
        )

        XCTAssertTrue(app.buttons["Delete"].exists)
        XCTAssertTrue(app.buttons["Cancel"].exists)
    }
    
}
