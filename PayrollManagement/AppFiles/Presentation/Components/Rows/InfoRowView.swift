//
//  InfoRowView.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//

import SwiftUI

struct PayrollAmountRow: View {

    let title: String
    let value: String
    let valueColor: Color
    var titleWeight: Font.Weight = .medium
    var valueWeight: Font.Weight = .bold

    var body: some View {
        HStack {
            Text(title)
                .fontCustom(size: 14, weight: titleWeight)
                .foregroundColor(.secondary)

            Spacer()

            Text(value)
                .fontCustom(size: 14, weight: valueWeight)
                .foregroundColor(valueColor)
        }
    }
}

#Preview {
    PayrollAmountRow(title: "Vikram", value: "15000", valueColor: .black, titleWeight: .regular, valueWeight: .medium)
}
