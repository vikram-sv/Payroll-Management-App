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

    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            SummaryRow(label: "Name", value: employee.name)
            SummaryRow(label: "Total Wages", value: totalWages)
            SummaryRow(label: "Exempt", value: employee.isExempt ? "Yes" : "No")
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.white))
                .shadow(
                    color: Color(red: 149/255, green: 157/255, blue: 165/255)
                        .opacity(0.2),
                    radius: 5
                )
        )
        .padding(.horizontal, 5)
        .overlay(
            ZStack {
                Button {
                    // MARK: DELETE
                    
                } label: {
                    Image(systemName: "trash")
                        .font(.system(size: 15))
                        .foregroundColor(Color.red)
                        .frame(width: 35, height: 35)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 2/*, x: 0, y: 2*/)
                }

            }
            .padding(15),
            alignment: .bottomTrailing
        )
        
    }
    
}

#Preview {
    EmployeeCardView(
        employee:
            Employee(name: "Vikram", wages: 19000, isExempt: true)
    )
}
