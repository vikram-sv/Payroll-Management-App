//
//  ToastModifier.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//


import SwiftUI

struct ToastModifier: ViewModifier {

    @Binding var isPresented: Bool
    let message: String

    func body(content: Content) -> some View {
        ZStack {
            content

            VStack {
                Spacer()

                if isPresented {
                    ToastView(message: message)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .animation(.easeInOut(duration: 0.25), value: isPresented)
        .onChange(of: isPresented) { show in
            guard show else { return }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isPresented = false
                }
            }
        }
    }
}

extension View {
    func toast(
        isPresented: Binding<Bool>,
        message: String
    ) -> some View {
        modifier(
            ToastModifier(
                isPresented: isPresented,
                message: message
            )
        )
    }
}
