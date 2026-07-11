//
//  Employee.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import Foundation

struct Employee: Identifiable {
    let id: UUID
    let name: String
    let wages: Double
    let isExempt: Bool
}
