//
//  PayrollListViewModelTests.swift
//  PayrollManagementTests
//
//  Created by Vikram Sukumaran on 09/07/26.
//

import XCTest
@testable import PayrollManagement

@MainActor
final class PayrollListViewModelTests: XCTestCase {
    
    var sut: PayrollListViewModel!
    var mockRepository: MockPayrollRepository!

    override func setUpWithError() throws {
        mockRepository = MockPayrollRepository()
        sut = PayrollListViewModel(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        mockRepository = nil
        sut = nil
    }
    
    func testFetchPayrolls_withPayrolls_shouldUpdateViewStateToLoaded() {
        let payroll = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: []
        )

        mockRepository.fetchPayrollResult = [payroll]

        sut.fetchPayrolls()

        XCTAssertEqual(sut.payrollLists.count, 1)
        XCTAssertEqual(sut.viewState, .loaded)
    }
    
    func testFetchPayrolls_withNoPayrolls_shouldUpdateViewStateToEmpty() {
        mockRepository.fetchPayrollResult = []

        sut.fetchPayrolls()

        XCTAssertEqual(sut.payrollLists.count, 0)
        XCTAssertEqual(sut.viewState, .empty)
    }
    
    func testFetchPayrolls_whenRepositoryThrows_shouldUpdateViewStateToError() {
        mockRepository.shouldThrowFetchError = true

        sut.fetchPayrolls()

        if case .error(let message) = sut.viewState {
            XCTAssertEqual(message, "Fetch failed")
        } else {
            XCTFail("Expected viewState to be .error")
        }
    }
    
    func testDeletePayroll_withPayroll_shouldCalledRepository() {
       
        let employee = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1000,
            isExempt: true
        )
        
        let payroll = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: [employee]
        )
        
        sut.payrollLists.append(payroll)
        
        sut.deletePayroll(
            Payroll(
                id: payroll.id,
                createdDate: payroll.createdDate,
                employees: payroll.employees
            )
        )
        
        XCTAssertTrue(mockRepository.deletePayrollCalled)
        
    }
    
    func testDeletePayroll_whenRepositoryThrows_shouldReturnError() {

        mockRepository.shouldThrowDeleteError = true

        let payroll = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: []
        )

        sut.deletePayroll(payroll)

        if case .error(let message) = sut.viewState {
            XCTAssertEqual(message, "Delete failed")
        } else {
            XCTFail("Expected .error state")
        }
    }
    
    func testDeletePayroll_whenLastPayrollDeleted_shouldUpdateViewStateToEmpty() {
        let payroll = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: []
        )

        sut.payrollLists = [payroll]

        sut.deletePayroll(payroll)

        XCTAssertEqual(sut.viewState, .empty)
    }

    func testDeletePayroll_withCorrectMatchedPayrollId_shouldDeletePayroll() {
       
        let employee1 = Employee(
            id: UUID(),
            name: "Vikram",
            wages: 1000,
            isExempt: true
        )
        
        let employee2 = Employee(
            id: UUID(),
            name: "Hello",
            wages: 15000,
            isExempt: false
        )
        
        let payroll1 = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: [employee1]
        )
        
        let payroll2 = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: [employee2]
        )
        
        sut.payrollLists.append(payroll1)
        sut.payrollLists.append(payroll2)
        
        sut.deletePayroll(
            Payroll(
                id: payroll1.id,
                createdDate: payroll1.createdDate,
                employees: payroll1.employees
            )
        )
        
        XCTAssertEqual(sut.payrollLists.count, 1)
        
    }
    
    func testUpdatePayrollInList_WhenPayrollExists_ShouldUpdatePayroll() {
        
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
        
        sut.payrollLists.append(payroll)
        
        let updatedEmployee = Employee(
            id: employee.id,
            name: "Vikram",
            wages: 2000,
            isExempt: false
        )
        
        let updatedPayroll = Payroll(
            id: payroll.id,
            createdDate: payroll.createdDate,
            employees: [updatedEmployee]
        )
        
        sut.updatePayrollInList(updatedPayroll)
        
        XCTAssertEqual(sut.payrollLists.count, 1)
        XCTAssertEqual(sut.payrollLists.first?.employees.first?.name, "Vikram")
        XCTAssertEqual(sut.payrollLists.first?.employees.first?.wages, 2000)
        XCTAssertFalse(sut.payrollLists.first?.employees.first?.isExempt ?? true)
    }
    
    func testUpdatePayrollInList_WhenPayrollDoesNotExist_ShouldNotUpdate() {

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

        sut.payrollLists = [payroll]

        let updatedPayroll = Payroll(
            id: UUID(),
            createdDate: payroll.createdDate,
            employees: [
                Employee(
                    id: UUID(),
                    name: "John",
                    wages: 3000,
                    isExempt: true
                )
            ]
        )

        sut.updatePayrollInList(updatedPayroll)

        XCTAssertEqual(sut.payrollLists.count, 1)
        XCTAssertEqual(sut.payrollLists.first?.employees.first?.name, "Vikram")
        XCTAssertEqual(sut.payrollLists.first?.employees.first?.wages, 1200)
        XCTAssertFalse(sut.payrollLists.first?.employees.first?.isExempt ?? true)
    }
    
    

}
