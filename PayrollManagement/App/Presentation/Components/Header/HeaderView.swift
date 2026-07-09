//
//  HeaderView.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct HeaderView: View {
    
    var headerName: String
    var fontsize: CGFloat
    var fontWeight: Font.Weight
    var foregroundColor: Color
    var position: Alignment
    
    init(
        headerName: String,
        fontsize: CGFloat = 26,
        fontWeight: Font.Weight = .bold,
        foregroundColor: Color = .primary,
        position: Alignment = .leading
    ) {
        self.headerName = headerName
        self.fontsize = fontsize
        self.fontWeight = fontWeight
        self.foregroundColor = foregroundColor
        self.position = position
    }
    
    var body: some View {
        Text(headerName)
            .font(.system(size: fontsize, weight: fontWeight))
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity, alignment: position)
            .padding(5)
    }
}

#Preview {
    HeaderView(headerName: "Payroll Lists")
}
