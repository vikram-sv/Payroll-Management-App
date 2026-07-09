//
//  TaxCalculator.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//


import Foundation

struct TaxCalculator {

    static func calculateTax(for employee: Employee) -> Double {

        guard employee.wages > 1000,
              !employee.isExempt else {
            return 0
        }

        return employee.wages * 0.05
    }

    static func calculateNet(for employee: Employee) -> Double {

        employee.wages - calculateTax(for: employee)
    }
    
}
