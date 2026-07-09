//
//  EditPayrollViewModel.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//

import Foundation
import Combine

class EditPayrollViewModel: ObservableObject {
    
    private let repository: PayrollRepository
    
    private let payrollId: UUID
    private let createdDate: Date
    
    @Published var employees: [Employee] = []
    @Published var toastMessage: String?
    @Published var showToast = false
    @Published var selectedEmployee: Employee? = nil
    
    init(payroll: Payroll, repository: PayrollRepository = PayrollRepositoryImpl()) {
        self.payrollId = payroll.id
        self.createdDate = payroll.createdDate
        self.employees = payroll.employees
        self.repository = repository
    }
    
    func addEmployee(_ employee: Employee) {
        employees.append(employee)
    }
    
    func updateEmployee(_ employee: Employee) {
        guard let index = employees.firstIndex(where: { $0.id == employee.id }) else { return }
        employees[index] = employee
    }
    
    func removeEmployee(_ employee: Employee) {
        employees.removeAll(where: { $0.id == employee.id })
    }
    
    func validateEmployee(id: UUID? = nil, name: String, wages: Double, isExempt: Bool) throws -> Employee {
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            throw EmployeeValidationError.emptyName
        }
        
        guard wages > 0 else {
            throw EmployeeValidationError.invalidWages
        }
        
        return Employee(
            id: id ?? UUID(),
            name: trimmedName,
            wages: wages,
            isExempt: isExempt
        )
    }
    
    // MARK: UPDATE PAYROLL IN DB
    @discardableResult
    func updatePayroll() throws -> Payroll {
        
        guard !employees.isEmpty else {
            throw EmployeeValidationError.emptyName
        }
        
        let payroll = Payroll(
            id: payrollId,
            createdDate: createdDate,
            employees: employees
        )
        
        try repository.updatePayroll(payroll)
        
        return payroll
    }
}
