//
//  PayrollDetailView.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//

import SwiftUI

struct PayrollDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let payroll: Payroll
    
    private var formattedDate: String {
        DateFormatter.payrollDisplay.string(from: payroll.createdDate)
    }
    
    private var totalTaxes: Double {

        var total: Double = 0

        for employee in payroll.employees {
            total += TaxCalculator.calculateTax(for: employee)
        }

        return total
    }
    
    private var totalWages: Double {

        var wages: Double = 0

        for employee in payroll.employees {
            wages += employee.wages
        }

        return wages
    }
    
    private var totalNet: Double {

        var netTotal: Double = 0

        for employee in payroll.employees {
            netTotal += TaxCalculator.calculateNet(for: employee)
        }

        return netTotal
    }
    
    private var totalTaxFormated: String {
        NumberFormatter.currency.string(from: NSNumber(value: totalTaxes)) ?? "0.0"
    }
    
    private var totalWagesFormated: String {
        NumberFormatter.currency.string(from: NSNumber(value: totalWages)) ?? "0.0"
    }
    
    private var totalNetFormated: String {
        NumberFormatter.currency.string(from: NSNumber(value: totalNet)) ?? "0.0"
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - HEADER
                header
                
                HStack(spacing: 10) {
                    Text("Created at:")
                        .fontCustom(size: 18, weight: .semibold)
                        .foregroundColor(Color.black)
                    
                    Spacer()
                    
                    Text(formattedDate)
                        .fontCustom(size: 17, weight: .medium)
                        .foregroundColor(.blue)
                        .accessibilityIdentifier("CreatedDate")
                }
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(payroll.employees) { employee in
                            EmployeeDetailCardView(
                                employee: employee,
                                onDelete: nil
                            )
                        }
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 220)
                }
                
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            VStack(alignment: .leading, spacing: 15) {
                ReusableRowView(title: "Total Wages", value: totalWagesFormated, valueColor: .primary)
                
                ReusableRowView(title: "Total Tax Deducted", value: totalTaxFormated, valueColor: .red)
                
                Divider()
                
                ReusableRowView(title: "Total Net", value: totalNetFormated, valueColor: Color.AppColors.ThemeGreen)
            }
            .padding(24)
            .padding(.bottom, 34)
            .background(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: -4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color(.systemGray5), lineWidth: 1)
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
            
            
        }
        .navigationBarHidden(true)
        
    }
}

#Preview {
    PayrollDetailView(
        payroll: Payroll(
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

extension PayrollDetailView {
    
    private var header: some View {
        HStack(spacing: 15) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(10)
                    .contentShape(Rectangle())
            }
            .accessibilityIdentifier("BackButton")

            HeaderView(headerName: "Payroll Details")
                .accessibilityIdentifier("PayrollDetailsHeader")
        }
    }
    
}
