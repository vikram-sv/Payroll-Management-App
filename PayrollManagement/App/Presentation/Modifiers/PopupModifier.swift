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
        ZStack(alignment: .bottom) {
            content

            if isPresented {
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isPresented = false
                        }
                    }

                popup()
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

extension View {

    func appPopup<PopupContent: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> PopupContent
    ) -> some View {

        modifier(
            PopupModifier(
                isPresented: isPresented,
                popup: content
            )
        )
    }
}
