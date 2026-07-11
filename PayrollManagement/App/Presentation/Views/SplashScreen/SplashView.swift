//
//  SplashView.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 11/07/26.
//


import SwiftUI

struct SplashView: View {
    
    @State private var scale: CGFloat = 0.3
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)
                    .scaleEffect(scale, anchor: .center)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            withAnimation(.easeIn(duration: 1.5)) {
                                scale = 1.0
                            }
                        }
                    }
            }
            
            VStack {
                Spacer()
                VStack(spacing: 5) {
                    Text(Constants.appname)
                        .fontCustom(size: 35, weight: .bold)
                        .foregroundColor(Color.AppColors.ThemeNavy)
                        .opacity(scale == 1 ? 1 : 0)
                        .animation(.easeIn(duration: 0.5).delay(0.8), value: scale)
                }
                .frame(height: 100)
            }
            .padding()
        }
        .accessibilityIdentifier("SplashScreen")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .navigationBarHidden(true)
    }
}


#Preview {
    SplashView()
}
