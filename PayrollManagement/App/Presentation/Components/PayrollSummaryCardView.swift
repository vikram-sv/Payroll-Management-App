//
//  PayrollSummaryCardView.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct PayrollSummaryCardView: View {

    let detail: Payroll

    private var dateFormatted: String {
        DateFormatter.payrollDisplay.string(from: detail.createdDate)
    }

    private var totalWages: Double {

        var total: Double = 0

        for employee in detail.employees {
            total += employee.wages
        }

        return total
    }

    private var totalFormatted: String {
        NumberFormatter.currency.string(
            from: NSNumber(value: totalWages)
        ) ?? "$0.00"
    }

    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            SummaryRow(label: "Created", value: dateFormatted)
            SummaryRow(label: "Employees", value: "\(detail.employees.count)")
            SummaryRow(label: "Total", value: totalFormatted)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal, 5)
        
    }
    
}

#Preview {
    PayrollSummaryCardView(
        detail:
            Payroll(
                id: UUID(),
                createdDate: Date(),
                employees: [
                    Employee(
                    id: UUID(),
                    name: "Vikram",
                    wages: 1500,
                    isExempt: true
                )
                ]
            )
    )
}
