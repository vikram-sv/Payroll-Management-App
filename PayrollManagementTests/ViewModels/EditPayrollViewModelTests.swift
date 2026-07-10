//
//  EditPayrollViewModelTests.swift
//  PayrollManagementTests
//
//  Created by Vikram Sukumaran on 10/07/26.
//

import XCTest
@testable import PayrollManagement

final class EditPayrollViewModelTests: XCTestCase {
    
    var sut: EditPayrollViewModel!
    var mockRepository: MockPayrollRepository!
    var payroll: Payroll!

    override func setUpWithError() throws {
        mockRepository = MockPayrollRepository()
        
        payroll = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: []
        )
        
        sut = EditPayrollViewModel(payroll: payroll, repository: mockRepository)
    }

    override func tearDownWithError() throws {
        sut = nil
        payroll = nil
        mockRepository = nil
    }
    
    func testInit_ShouldLoadPayrollEmployees() {

        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1200,
            isExempt: false
        )

        let payroll = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: [employee]
        )

        let sut = EditPayrollViewModel(
            payroll: payroll,
            repository: mockRepository
        )

        XCTAssertEqual(sut.employees.count, 1)
        XCTAssertEqual(sut.employees.first?.name, "Vikram")
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
    
    func testUpdatePayroll_withoutEmptyEmployee_shoudReturnErrorAsEmptyPayroll() {
        
        sut.employees = []
        
        do {
            let _ = try sut.updatePayroll()
            
            XCTFail("Need to throw an Empty payroll error")
        } catch {
            XCTAssertEqual(error as? EmployeeValidationError, .emptyPayroll)
        }
        
    }
    
    func testUpdatePayroll_withEmployee_shouldCallRepository() throws {
        
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1000,
            isExempt: false
        )
        
        sut.addEmployee(employee)
        
        let _ = try sut.updatePayroll()
        
        XCTAssertTrue(mockRepository.updatePayrollCalled)
    }
    
    func testUpdatePayroll_ShouldPassUpdatedEmployeesToRepository() throws {

        let employee = Employee(
            id: UUID(),
            name: "John",
            wages: 1500,
            isExempt: false
        )

        sut.addEmployee(employee)

        _ = try sut.updatePayroll()

        XCTAssertEqual(mockRepository.updatedPayroll?.employees.count, 1)
    }

}
