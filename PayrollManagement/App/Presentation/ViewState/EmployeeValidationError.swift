//
//  EmployeeValidationError.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//

import Foundation

enum EmployeeValidationError: LocalizedError {
    case emptyName
    case invalidWages
    
    var errorDescription: String? {
        switch self {
        case .emptyName:
            return "Please enter a valid employee name."
        case .invalidWages:
            return "Please enter valid wages greater than 0."
        }
    }
}
