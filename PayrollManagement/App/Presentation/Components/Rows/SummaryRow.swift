//
//  SummaryRow.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct SummaryRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack(spacing: 4) {
            Text(label)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)

            Text(": ")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)

            Text(value)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.primary)
        }
    }
}
