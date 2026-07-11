//
//  EmployeeCardView.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct EmployeeCardView: View {

    let employee: Employee
    
    private var totalWages: String {
        NumberFormatter.currency.string(from: NSNumber(value: employee.wages)) ?? "$0.00"
    }
    
    var onDelete: ((Employee) -> Void)? = nil

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
 
            Image(systemName: "person.fill")
                .fontCustom(size: 18, weight: .regular)
                .foregroundColor(Color.AppColors.ThemeNavy)
                .frame(width: 44, height: 44)
                .background(Color.AppColors.ThemeBlueBG)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 6) {
                Text(employee.name)
                    .fontCustom(size: 16, weight: .bold)
                    .foregroundColor(.primary)
                
                HStack(spacing: 8) {
                    Text(totalWages)
                        .fontCustom(size: 14, weight: .semibold)
                        .foregroundColor(Color.AppColors.ThemeGreen)
                    
                    if employee.isExempt {
                        Text("Tax Exempt")
                            .fontCustom(size: 11, weight: .medium)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color(.systemGray6))
                            .foregroundColor(.secondary)
                            .cornerRadius(4)
                    }
                }
            }
            
            Spacer()
            
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
                .accessibilityIdentifier("DeleteEmployeeButton_\(employee.name)")
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
    EmployeeCardView(
        employee:
            Employee(
                id: UUID(),
                name: "Vikram",
                wages: 19000,
                isExempt: true
            )
    )
}
