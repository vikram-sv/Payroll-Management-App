//
//  ReusableRowView.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//


import SwiftUI

struct ReusableRowView: View {

    let title: String
    let value: String
    var valueColor: Color = .black
    var titleColor: Color = .black

    var body: some View {
        HStack {
            Text(title)
                .fontCustom(size: 18, weight: .semibold)
                .foregroundColor(titleColor)

            Spacer(minLength: 0)

            Text(value)
                .fontCustom(size: 19, weight: .semibold)
                .foregroundColor(valueColor)
        }
    }
}
