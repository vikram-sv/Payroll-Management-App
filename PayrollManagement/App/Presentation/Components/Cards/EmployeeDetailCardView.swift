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
    
    var onDelete: ((Employee) -> Void)? = nil
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {

            Image(systemName: "person.text.rectangle.fill")
                .fontCustom(size: 20, weight: .regular)
                .foregroundColor(Color.AppColors.ThemeNavy)
                .frame(width: 42, height: 42)
                .background(Color.AppColors.ThemeBlueBG)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 15) {
                    Text(employee.name)
                        .fontCustom(size: 16, weight: .bold)
                        .foregroundColor(.primary)
                    
                    if employee.isExempt {
                        Text("Exempt")
                            .fontCustom(size: 10, weight: .semibold)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(.systemGray6))
                            .cornerRadius(4)
                    }
                }
                
                VStack(spacing: 8) {
                    PayrollAmountRow(
                        title: "Gross Wages:",
                        value: wagesFormatted,
                        valueColor: .primary
                    )

                    PayrollAmountRow(
                        title: "Tax Deducted:",
                        value: taxFormatted,
                        valueColor: Color.AppColors.ThemeRed,
                        valueWeight: .semibold
                    )

                    PayrollAmountRow(
                        title: "Net Payout:",
                        value: netFormatted,
                        valueColor: Color.AppColors.ThemeGreen
                    )
                }
            }
            
            if onDelete != nil {
                Button {
                    onDelete?(employee)
                } label: {
                    Image(systemName: "trash")
                        .fontCustom(size: 13, weight: .regular)
                        .foregroundColor(Color.AppColors.ThemeRed)
                        .frame(width: 32, height: 32)
                        .background(Color(.systemGray6))
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color(.systemGray5), lineWidth: 1)
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
