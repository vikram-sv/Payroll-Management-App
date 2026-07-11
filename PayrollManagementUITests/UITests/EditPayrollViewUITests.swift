//
//  EditPayrollViewUITests.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 11/07/26.
//


import XCTest
@testable import PayrollManagement

final class EditPayrollViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        launchApp()
    }

    private func launchApp() {

        app = XCUIApplication()
        app.launchArguments = ["UITestingWithData"]
        app.launch()

        navigateToEditPayroll()
    }

    private func navigateToEditPayroll() {

        let editButton = app.buttons["EditPayrollButton"].firstMatch

        XCTAssertTrue(
            editButton.waitForExistence(timeout: 3)
        )

        editButton.tap()
    }
    
    func testEditPayroll_WhenOpened_ShouldShowHeader() {

        XCTAssertTrue(
            app.staticTexts["Edit Payroll"]
                .waitForExistence(timeout: 3)
        )
    }
    
    func testEditPayroll_WhenOpened_ShouldShowEmployees() {

        XCTAssertTrue(
            app.staticTexts["John"]
                .waitForExistence(timeout: 3)
        )

        XCTAssertTrue(
            app.staticTexts["Vikram"]
                .waitForExistence(timeout: 3)
        )
    }
    
    func testEditPayroll_WhenAddEmployeeTapped_ShouldOpenAddEmployeeSheet() {

        app.buttons["EditAddEmployeeButton"].firstMatch.tap()

        XCTAssertTrue(
            app.textFields["EmployeeNameField"]
                .firstMatch
                .waitForExistence(timeout: 3)
        )
    }
    
    func testEditPayroll_WhenUpdatePayrollTapped_ShouldDismissScreen() {

        app.buttons["UpdatePayrollButton"].firstMatch.tap()

        XCTAssertTrue(
            app.staticTexts["PayrollHubIdentifier"]
                .waitForExistence(timeout: 3)
        )
    }
    
    func testEditPayroll_WhenEmployeeEdited_ShouldUpdateEmployee() {
        
        let vikram = app.staticTexts["Vikram"].firstMatch

        XCTAssertTrue(vikram.waitForExistence(timeout: 3))

        vikram.tap()

        let nameField = app.textFields["EmployeeNameField"].firstMatch

        XCTAssertTrue(nameField.waitForExistence(timeout: 3))

        nameField.tap()
        nameField.typeText(" Sukumaran")
        
        app.buttons["Return"].firstMatch.tap()

        app.buttons["SubmitEmployeeButton"].firstMatch.tap()
        
        XCTAssertTrue(
            app.staticTexts["Vikram Sukumaran"]
                .waitForExistence(timeout: 3)
        )
        
        app.buttons["Update Payroll"].firstMatch.tap()
        
    }
    
    func testEditPayroll_WhenEmployeeDeleted_ShouldUpdateEmployeeList() {
        
        app.buttons["DeleteEmployeeButton_Vikram"].tap()

        XCTAssertFalse(
            app.staticTexts["Vikram"].exists
        )

        app.buttons["UpdatePayrollButton"].tap()
        
        XCTAssertTrue(
            app.staticTexts["1 Employees"]
                .waitForExistence(timeout: 3)
        )
    }
    
    func testEditPayroll_WhenAllEmployeesDeleted_ShouldShowPlaceholder() {

        app.buttons["DeleteEmployeeButton_John"].tap()
        app.buttons["DeleteEmployeeButton_Vikram"].tap()

        XCTAssertTrue(
            app.staticTexts["AddEmployeesPlaceHolder"]
                .waitForExistence(timeout: 3)
        )

        XCTAssertTrue(
            app.buttons["Add Employee"]
                .waitForExistence(timeout: 3)
        )
    }
}
