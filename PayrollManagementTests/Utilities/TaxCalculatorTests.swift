//
//  TaxCalculatorTests.swift
//  PayrollManagementTests
//
//  Created by Vikram Sukumaran on 09/07/26.
//

import XCTest
@testable import PayrollManagement

final class TaxCalculatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testtax_WhenWagesLessThan1000_shouldReturnZero() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 900,
            isExempt: true
        )
        
        let tax = TaxCalculator.calculateTax(for: employee)
        
        XCTAssertEqual(tax, 0)
        
    }
    
    func testtax_WhenWagesExactly1000_shouldReturnZero() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1000,
            isExempt: true
        )
        
        let tax = TaxCalculator.calculateTax(for: employee)
        
        XCTAssertEqual(tax, 0)
        
    }
    
    func testtax_WhenWagesGreaterThan1000_andIsExempt_shouldReturnZero() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1100,
            isExempt: true
        )
        
        let tax = TaxCalculator.calculateTax(for: employee)
        
        XCTAssertEqual(tax, 0)
    }
    
    func testtax_WhenWagesGreaterThan1000_andIsNotExempt_shouldReduceFivePercent() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1100,
            isExempt: false
        )
        
        let tax = TaxCalculator.calculateTax(for: employee)
        
        // 1100 --> 5% -- 55
        XCTAssertEqual(tax, 55)
    }
    
    func testNet_WhenEmployeeIsExempt_shouldReturnFullWages() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 2000,
            isExempt: true
        )
        
        let net = TaxCalculator.calculateNet(for: employee)
        
        XCTAssertEqual(net, 2000)
        
    }
    
    func testNet_WhenEmployeeIsNotExempt_AndWagesLessThan1000_shouldReturnFullWages() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 900,
            isExempt: false
        )
        
        let net = TaxCalculator.calculateNet(for: employee)
        
        XCTAssertEqual(net, 900)
        
    }
    
    func testNet_WhenEmployeeIsNotExempt_AndWagesExactly1000_shouldReturnFullWages() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1000,
            isExempt: false
        )
        
        let net = TaxCalculator.calculateNet(for: employee)
        
        XCTAssertEqual(net, 1000)
        
    }
    
    func testNet_WhenEmployeeIsNotExempt_AndWagesGreaterThan1000_shouldReduceFivePercent() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1100,
            isExempt: false
        )
        
        let net = TaxCalculator.calculateNet(for: employee)
        
        // 1100 --> 5% - 55 == 1100 - 55 = 1045
        XCTAssertEqual(net, 1045)
        
    }

}
