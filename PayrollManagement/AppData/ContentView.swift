//
//  ContentView.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isSplashDismissed: Bool = false
    
    var body: some View {
        NavigationView {
            
            // MARK: ROOT CONNECTION
            MainRootView
            
        }
    }
    
    private func timerForDismiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            dismissSplash()
        }
    }
    
    private func dismissSplash() {
        isSplashDismissed = true
    }

}

#Preview {
    ContentView()
}

extension ContentView {
    private var MainRootView: some View {
        ZStack {
            if isSplashDismissed {
                PayrollListView()
            } else {
                SplashView()
                    .onAppear(perform: {
                        timerForDismiss()
                    })
            }
        }
    }
}
