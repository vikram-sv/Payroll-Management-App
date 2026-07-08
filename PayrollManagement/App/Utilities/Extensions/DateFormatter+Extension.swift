//
//  DateFormatter.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import Foundation

// MARK: DATE FORMATTERS

extension DateFormatter {
    static let payrollInput: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()

    static let payrollDisplay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
}

