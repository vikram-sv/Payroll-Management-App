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
            VStack(spacing: 20) {
                
                Text(title)
                    .fontCustom(size: 22, weight: .bold)
                    .foregroundColor(.primary)

                Text(message)
                    .fontCustom(size: 17, weight: .regular)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                HStack(spacing: 15) {

                    if let secondaryTitle {
                        Button {
                            secondaryAction?()
                        } label: {
                            Text(secondaryTitle)
                                .fontCustom(size: 17, weight: .medium)
                                .foregroundColor(Color.primary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }

                    Button {
                        primaryAction()
                    } label: {
                        Text(primaryTitle)
                            .fontCustom(size: 17, weight: .medium)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .padding(25)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0, y: 5)
            .padding(.horizontal, 30)
            
        }
    }
}
