//
//  PayrollRepository.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//

import Foundation

protocol PayrollRepository {
    
    func savePayroll(_ payroll: Payroll) throws 
    
    func fetchPayrolls() throws -> [Payroll]
    
}
