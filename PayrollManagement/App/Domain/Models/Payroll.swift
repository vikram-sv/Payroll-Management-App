//
//  Payroll.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//

import Foundation

struct Payroll: Identifiable {
    let id: UUID
    let createdDate: Date
    let employees: [Employee]
}
