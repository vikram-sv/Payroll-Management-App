//
//  CreatePayrollViewModelTests.swift
//  PayrollManagementTests
//
//  Created by Vikram Sukumaran on 09/07/26.
//

import XCTest
@testable import PayrollManagement

final class CreatePayrollViewModelTests: XCTestCase {
    
    var sut: CreatePayrollViewModel!
    var mockRepository: MockPayrollRepository!

    override func setUpWithError() throws {
        
        mockRepository = MockPayrollRepository()
        sut = CreatePayrollViewModel(repository: mockRepository)
        
    }

    override func tearDownWithError() throws {
    
        sut = nil
        mockRepository = nil
        
    }

    func testAddEmployee_shouldAppendEmployee() {
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1000,
            isExempt: true
        )
        
        sut.addEmployee(employee)
        
        XCTAssertEqual(sut.employees.count, 1)
        XCTAssertEqual(sut.employees.first?.name, "Vikram")
    }
    
    func testValidateEmployee_withEmptyName_shouldReturnErrorAsEmptyName() {
        
        let employee = Employee(
            id: UUID(),
            name: "",
            wages: 1000,
            isExempt: true
        )
        
        do {
            let _ = try sut.validateEmployee(name: employee.name, wages: employee.wages, isExempt: employee.isExempt)
            
            XCTFail("Need to throw empty name error")
        } catch {
            XCTAssertEqual(error as? EmployeeValidationError, .emptyName)
        }
    }
    
    func testValidateEmployee_withEmptySpace_shouldReturnErrorAsEmptyName() {
        
        let employee = Employee(
            id: UUID(),
            name: "   ",
            wages: 1000,
            isExempt: true
        )
        
        do {
            let _ = try sut.validateEmployee(name: employee.name, wages: employee.wages, isExempt: employee.isExempt)
            
            XCTFail("Need to throw empty name error")
        } catch {
            XCTAssertEqual(error as? EmployeeValidationError, .emptyName)
        }
    }
    
    func testValidateEmployee_withWagesLessThanOrEqualZero_shouldReturnErrorAsWagesInvalidWagesAsError() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 0,
            isExempt: true
        )
        
        do {
            let _ = try sut.validateEmployee(name: employee.name, wages: employee.wages, isExempt: employee.isExempt)
            
            XCTFail("Need to throw invalid Wages error")
        } catch {
            XCTAssertEqual(error as? EmployeeValidationError, .invalidWages)
        }
    }
    
    func testValidateEmployee_withCorrectDetails_shouldReturnEmployee() throws {

        let id = UUID()

        let result = try sut.validateEmployee(
            id: id,
            name: "Vikram",
            wages: 1000,
            isExempt: true
        )

        XCTAssertEqual(result.id, id)
        XCTAssertEqual(result.name, "Vikram")
        XCTAssertEqual(result.wages, 1000)
        XCTAssertTrue(result.isExempt)
    }
    
    func testSavePayroll_WhenEmployeesAreEmpty_ShouldNotCallRepository() throws {

        sut.employees = []

        try sut.savePayroll()

        XCTAssertFalse(mockRepository.savePayrollCalled)
    }
    
    func testSavePayroll_WithEmployees_ShouldCallRepository() throws {

        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1200,
            isExempt: false
        )
        
        sut.addEmployee(employee)

        try sut.savePayroll()

        XCTAssertTrue(mockRepository.savePayrollCalled)
    }

    func testSavePayroll_ShouldSaveCorrectEmployee() throws {

        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1200,
            isExempt: false
        )

        sut.addEmployee(employee)

        try sut.savePayroll()

        XCTAssertEqual(mockRepository.savedPayroll?.employees.count, 1)
        XCTAssertEqual(mockRepository.savedPayroll?.employees.first?.name, "Vikram")
    }
    
    func testUpdateEmployee_WhenEmployeeExists_ShouldUpdateEmployee() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1200,
            isExempt: false
        )
        
        sut.addEmployee(employee)
        
        let updatedEmployee = Employee(
            id: employee.id,
            name: "Vikram",
            wages: 1000,
            isExempt: true
        )
        
        sut.updateEmployee(updatedEmployee)
        
        XCTAssertEqual(sut.employees.count, 1)
            XCTAssertEqual(sut.employees.first?.name, "Vikram")
            XCTAssertEqual(sut.employees.first?.wages, 1000)
            XCTAssertTrue(sut.employees.first?.isExempt ?? false)
    }
    
    func testUpdateEmployee_WhenEmployeeDoesNotExist_ShouldNotUpdateEmployees() {
        
        let updatedEmployee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1000,
            isExempt: true
        )
        
        sut.updateEmployee(updatedEmployee)
        
        XCTAssertTrue(sut.employees.isEmpty)
    }
    
    func testRemoveEmployee_WhenEmployeeExists_ShouldRemoveEmployee() {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1200,
            isExempt: false
        )
        
        sut.addEmployee(employee)
        
        sut.removeEmployee(employee)
        
        XCTAssertTrue(sut.employees.isEmpty)
    }
    
    func testRemoveEmployee_WhenEmployeeDoesNotExists_ShouldNotRemoveEmployee() {
        
        let employee1 = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1000,
            isExempt: false
        )
        
        let employee2 = Employee(
            id: UUID(),
            name: "John",
            wages: 1500,
            isExempt: false
        )
        
        sut.addEmployee(employee1)
        
        sut.removeEmployee(employee2)
        
        XCTAssertEqual(sut.employees.count, 1)
        XCTAssertEqual(sut.employees.first?.name, "Vikram")
    }
    
}
