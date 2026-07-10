//
//  MockPayrollRepository.swift
//  PayrollManagementTests
//
//  Created by Vikram Sukumaran on 10/07/26.
//

import XCTest
@testable import PayrollManagement

final class MockPayrollRepository: PayrollRepository {
    
    var savePayrollCalled: Bool = false
    var savedPayroll: Payroll?
    
    var updatePayrollCalled = false
    var updatedPayroll: Payroll?
    
    var fetchPayrollResult: [Payroll] = []
    var shouldThrowFetchError = false
    
    var deletePayrollCalled: Bool = false
    var shouldThrowDeleteError = false
    
    var deleteAllPayrollCalled: Bool = false
    
    func savePayroll(_ payroll: Payroll) throws {
        savePayrollCalled = true
        savedPayroll = payroll
    }
    
    func fetchPayrolls() throws -> [Payroll] {
        if shouldThrowFetchError {
            throw MockError.fetchFailed
        }
        
        return fetchPayrollResult
    }
    
    func deletePayroll(id: UUID) throws {
        deletePayrollCalled = true
        
        if shouldThrowDeleteError {
            throw MockError.deleteFailed
        }
    }
    
    func updatePayroll(_ payroll: Payroll) throws {
        updatePayrollCalled = true
        updatedPayroll = payroll
    }
    
    func deleteAllPayrolls() throws {
        deleteAllPayrollCalled = true
    }
}

enum MockError: LocalizedError {
    case deleteFailed
    case fetchFailed

    var errorDescription: String? {
        switch self {
        case .deleteFailed:
            return "Delete failed"
        case .fetchFailed:
            return "Fetch failed"
        }
    }
}
