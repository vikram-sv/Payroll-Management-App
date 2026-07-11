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
    
    private var totalNet: Double {

        var totalNet: Double = 0

        for employee in detail.employees {
            totalNet += TaxCalculator.calculateNet(for: employee)
        }

        return totalNet
    }

    private var totalFormatted: String {
        NumberFormatter.currency.string(
            from: NSNumber(value: totalWages)
        ) ?? "$0.00"
    }
    
    private var netAmountFormatted: String {
        NumberFormatter.currency.string(
            from: NSNumber(value: totalNet)
        ) ?? "$0.00"
    }
    
    var onEdit: ((Payroll) -> Void)? = nil
    var onDelete: ((Payroll) -> Void)? = nil

    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            
            Image(systemName: "calendar")
                .fontCustom(size: 20, weight: .semibold)
                .foregroundColor(Color.AppColors.ThemeNavy)
                .frame(width: 44, height: 44)
                .background(Color.AppColors.ThemeBlueBG)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("CREATION DATE")
                            .fontCustom(size: 11, weight: .bold)
                            .foregroundColor(.secondary)
                        
                        Text(dateFormatted)
                            .fontCustom(size: 17, weight: .bold)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button {
                        onEdit?(detail)
                    } label: {
                        Image(systemName: "pencil.line")
                            .fontCustom(size: 13, weight: .regular)
                            .foregroundColor(Color.AppColors.ThemeNavy)
                            .frame(width: 32, height: 32)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityIdentifier("EditPayrollButton")
                    
                    Button {
                        onDelete?(detail)
                    } label: {
                        Image(systemName: "trash")
                            .fontCustom(size: 13, weight: .regular)
                            .foregroundColor(Color.AppColors.ThemeRed)
                            .frame(width: 32, height: 32)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityIdentifier("DeletePayrollButton")
                    
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("EMPLOYEE COUNT")
                        .fontCustom(size: 11, weight: .bold)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "person.2.fill")
                            .fontCustom(size: 12, weight: .medium)
                            .foregroundColor(.secondary)
                        
                        Text("\(detail.employees.count) Employees")
                            .fontCustom(size: 15, weight: .medium)
                            .foregroundColor(.primary)
                    }
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("TOTAL DISBURSED")
                        .fontCustom(size: 11, weight: .bold)
                        .foregroundColor(.secondary)
                    
                    Text(netAmountFormatted)
                        .fontCustom(size: 20, weight: .bold)
                        .foregroundColor(Color.AppColors.ThemeGreen)
                }
            }
        }
        .padding(20)
        .overlay(alignment: .bottomTrailing) {
            Image(systemName: "chevron.right")
                .fontCustom(size: 16, weight: .semibold)
                .foregroundColor(Color(.systemGray3))
                .padding(.bottom, 20)
                .padding(.trailing, 20)
        }
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
        .overlay(
            HStack {
                Rectangle()
                    .fill(Color.AppColors.ThemeGreen)
                    .frame(width: 4)
                Spacer()
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
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
