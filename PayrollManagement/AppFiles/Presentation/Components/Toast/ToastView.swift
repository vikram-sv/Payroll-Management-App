//
//  ToastView.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//


import SwiftUI

struct ToastView: View {

    let message: String

    var body: some View {
        Text(message)
            .fontCustom(size: 14, weight: .semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.black.opacity(0.85))
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
            .padding(.horizontal, 20)
    }
}
