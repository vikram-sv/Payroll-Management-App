//
//  PopupModifier.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//


import SwiftUI

struct PopupModifier<PopupContent: View>: ViewModifier {

    @Binding var isPresented: Bool
    let popup: () -> PopupContent

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()

                popup()
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: isPresented)
    }
}