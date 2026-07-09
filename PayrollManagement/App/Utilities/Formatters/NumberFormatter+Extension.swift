//
//  CurrencyFormatter.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import Foundation

// MARK: CURRENCY FORMATTER

extension NumberFormatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter
    }()
}
