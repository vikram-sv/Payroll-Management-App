//
//  AppTextField.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 07/07/2026.
//


import SwiftUI

struct AppTextField: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    
    init(
        title: String,
        placeholder: String = "",
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.keyboardType = keyboardType
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HeaderView(headerName: title, fontsize: 18, fontWeight: .medium)
            
            ZStack(alignment: .leading) {
                TextField("", text: $text)
                    .fontCustom(size: 16, weight: .regular)
                    .foregroundColor(.primary)
                    .disableAutocorrection(true)
                    .keyboardType(keyboardType)
                
                if text.isEmpty {
                    Text(placeholder)
                        .fontCustom(size: 16, weight: .regular)
                        .foregroundColor(.secondary.opacity(0.7))
                        .allowsHitTesting(false)
                }
            }
            .padding(.horizontal, 15)
            .frame(height: 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemGray5), lineWidth: 1.0)
            )
            .padding(.horizontal, 5)
        }
    }
    
    
}

#Preview {
    AppTextField(
        title: "Employee Name",
        placeholder: "Enter Employee Name",
        text: .constant("")
    )
}
