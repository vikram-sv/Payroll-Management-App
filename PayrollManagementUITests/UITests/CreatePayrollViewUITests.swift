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
    
    func testCreatePayroll_WhenEmployeeAdded_ShouldShowEmployeeInList() {

        let addEmployeeButton = app.buttons["AddEmployeesPlaceHolder"].firstMatch

        XCTAssertTrue(
            addEmployeeButton.waitForExistence(timeout: 3)
        )

        addEmployeeButton.tap()

        let nameField = app.textFields["EmployeeNameField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 3))
        nameField.tap()
        nameField.typeText("Vikram")
        
        app.buttons["Return"].firstMatch.tap()

        let wagesField = app.textFields["EmployeeWagesField"]
        XCTAssertTrue(wagesField.exists)
        wagesField.tap()
        wagesField.typeText("1500")
        
        app.buttons["Return"].firstMatch.tap()

        app.buttons["SubmitEmployeeButton"].firstMatch.tap()

        XCTAssertTrue(
            app.staticTexts["Vikram"]
                .waitForExistence(timeout: 3)
        )
    }
    
    func testCreatePayroll_WhenSavePayrollTapped_ShouldReturnToPayrollList() {

        let addEmployeeButton = app.buttons["AddEmployeesPlaceHolder"].firstMatch

        XCTAssertTrue(
            addEmployeeButton.waitForExistence(timeout: 3)
        )

        addEmployeeButton.tap()

        let nameField = app.textFields["EmployeeNameField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 3))
        nameField.tap()
        nameField.typeText("Vikram")

        app.buttons["Return"].firstMatch.tap()

        let wagesField = app.textFields["EmployeeWagesField"]
        XCTAssertTrue(wagesField.waitForExistence(timeout: 3))
        wagesField.tap()
        wagesField.typeText("1500")

        app.buttons["Return"].firstMatch.tap()

        app.buttons["SubmitEmployeeButton"].firstMatch.tap()

        XCTAssertTrue(
            app.buttons["SavePayrollButton"]
                .waitForExistence(timeout: 3)
        )

        app.buttons["SavePayrollButton"].tap()

        XCTAssertTrue(
            app.staticTexts["PayrollHubIdentifier"]
                .waitForExistence(timeout: 3)
        )

        XCTAssertTrue(
            app.buttons["CreatePayrollButton"]
                .waitForExistence(timeout: 3)
        )
    }
    
}
