//
//  AppPopup.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//


import SwiftUI

struct AppPopup: View {

    let title: String
    let message: String

    let primaryTitle: String
    let secondaryTitle: String?

    let primaryAction: () -> Void
    let secondaryAction: (() -> Void)?

    var body: some View {
        ZStack {
            Color.black.opacity(0.35)
                .ignoresSafeArea()

            VStack(spacing: 20) {

                Text(title)
                    .font(.title3.bold())

                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                HStack(spacing: 12) {

                    if let secondaryTitle {
                        Button(secondaryTitle) {
                            secondaryAction?()
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }

                    Button(primaryTitle) {
                        primaryAction()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(24)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 30)
        }
    }
}