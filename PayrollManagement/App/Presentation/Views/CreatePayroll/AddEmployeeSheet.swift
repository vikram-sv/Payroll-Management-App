//
//  AddEmployeeSheet.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct AddEmployeeSheet: View {
    
    @State private var employeeName: String = ""
    @State private var totalWages: String = ""
    @State private var isTaxExempt: Bool = false
    
    @State private var showToast: Bool = false
    @State private var toastMessage: String?
    
    @Environment(\.dismiss) var dismiss
    var onAdd: ((Employee) throws -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.clear
                .ignoresSafeArea()
                .onTapGesture { hideKeyboard() }
            
            VStack(alignment: .leading, spacing: 0) {
                header
                    .padding(.top)
                
                formFields
                    .padding(.top, 15)
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            addEmployeeButton
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .navigationBarHidden(true)
        .toast(
            isPresented: $showToast,
            message: toastMessage ?? "Please check the entered details"
        )
        .onChange(of: employeeName) { newValue in
            let filtered = newValue.filter { $0.isLetter || $0 == " " }
            let trimmed = String(filtered.drop(while: { $0 == " " }))
            let limited = String(trimmed.prefix(40))
            if limited != newValue {
                employeeName = limited
            }
        }
        .onChange(of: totalWages) { newValue in
            let filtered = newValue.filter { $0.isNumber }
            let limited = String(filtered.prefix(10))
            if limited != newValue {
                totalWages = limited
            }
        }
    }
}

#Preview {
    AddEmployeeSheet()
}

extension AddEmployeeSheet {
    
    private var header: some View {
        HStack(spacing: 15) {
            HeaderView(headerName: "Add Employee")
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.primary)
                    .padding(10)
                    .contentShape(Rectangle())
            }
        }
    }
    
    private var formFields: some View {
        VStack(spacing: 15) {
            AppTextField(
                title: "Employee Name",
                placeholder: "Ex: Vikram Sukumaran",
                text: $employeeName
            )
            
            AppTextField(
                title: "Total Wages",
                placeholder: "Enter the total wages",
                text: $totalWages,
                keyboardType: .numbersAndPunctuation
            )
            
            Toggle(isOn: $isTaxExempt) {
                HeaderView(headerName: "Tax Exempt", fontsize: 18, fontWeight: .medium)
            }
            .padding(5)
            .padding(.top, 10)
        }
    }
    
    private var addEmployeeButton: some View {
        Button {
            
            let employee = Employee(
                id: UUID(),
                name: employeeName,
                wages: Double(totalWages) ?? 0,
                isExempt: isTaxExempt
            )
            
            do {
                try onAdd?(employee)
                dismiss()
            } catch let error as EmployeeValidationError {
                toastMessage = error.errorDescription
                showToast = true
            } catch {
                toastMessage = "Something went wrong. Please try again."
                showToast = true
            }
            
        } label: {
            Text("Add Employee")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.AppColors.ThemeNavy)
                .cornerRadius(10)
                .contentShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
