//
//  EmployeeDetailCardView.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//

import SwiftUI

struct EmployeeDetailCardView: View {
    
    let employee: Employee
    
    private var wagesFormatted: String {
        NumberFormatter.currency.string(from: NSNumber(value: employee.wages)) ?? "0.0"
    }
    
    private var tax: Double {
        TaxCalculator.calculateTax(for: employee)
    }

    private var net: Double {
        TaxCalculator.calculateNet(for: employee)
    }
    
    private var taxFormatted: String {
        NumberFormatter.currency.string(
            from: NSNumber(value: tax)
        ) ?? "$0.00"
    }

    private var netFormatted: String {
        NumberFormatter.currency.string(
            from: NSNumber(value: net)
        ) ?? "$0.00"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SummaryRow(label: "Employee", value: employee.name)
            SummaryRow(label: "Wages", value: wagesFormatted)
            SummaryRow(label: "Exempt", value: employee.isExempt ? "Yes" : "No")
            SummaryRow(label: "Taxes", value: taxFormatted)
            SummaryRow(label: "Net", value: netFormatted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Rectangle()
                .fill(Color.white)
        )
        .overlay(
            ZStack {
                DeleteButton {
                    
                }
            }
            .padding(.trailing, 15 ),
            alignment: .bottomTrailing
        )
        .padding(.horizontal, 5)
    }
}

#Preview {
    EmployeeDetailCardView(
        employee: Employee(
            id: UUID(),
            name: "Vikram",
            wages: 15000,
            isExempt: true
        )
    )
}
