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
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.black)
                    .disableAutocorrection(true)
                    .keyboardType(keyboardType)
                
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(Color.black.opacity(0.3))
                        .allowsHitTesting(false)
                }
            }
            .padding(.horizontal, 15)
            .frame(height: 45)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 5.0)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(Color.gray, lineWidth: 1.0)
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
