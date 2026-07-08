//
//  CreatePayrollViewModel.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import Foundation
import Combine

class CreatePayrollViewModel: ObservableObject {
    
    @Published var employees: [Employee] = []
    
    func addEmployee(_ employee: Employee) {
        employees.append(employee)
    }
    
}
