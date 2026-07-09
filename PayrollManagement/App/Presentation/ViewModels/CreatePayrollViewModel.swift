//
//  CreatePayrollViewModel.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import Foundation
import Combine

class CreatePayrollViewModel: ObservableObject {
    
    private let repository: PayrollRepository
    
    init(repository: PayrollRepository = PayrollRepositoryImpl()) {
        self.repository = repository
    }
    
    @Published var employees: [Employee] = []
    
    func addEmployee(_ employee: Employee) {
        employees.append(employee)
    }
    
    func removeEmployee(_ employee: Employee) {
        employees.removeAll(where: { $0.id == employee.id })
    }
    
    // MARK: SAVE PAYROLL WHILE CREATING A NEW PAYROLL
    func savePayroll() throws {
        
        guard !employees.isEmpty else {
            return
        }
        
        let payroll = Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: employees
        )
        
        do {
            try repository.savePayroll(payroll)
        } catch let error {
            print("Error", String(describing: error))
        }
        
    }
    
}
