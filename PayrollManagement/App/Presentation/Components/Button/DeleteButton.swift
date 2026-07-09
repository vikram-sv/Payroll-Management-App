//
//  DeleteButton.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//


import SwiftUI

struct DeleteButton: View {

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "trash")
                .font(.system(size: 15))
                .foregroundColor(.red)
                .frame(width: 35, height: 35)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(
                    color: Color.black.opacity(0.1),
                    radius: 2
                )
        }
    }
}