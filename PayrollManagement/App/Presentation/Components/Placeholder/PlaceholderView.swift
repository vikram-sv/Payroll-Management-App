//
//  PlaceholderView.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct PlaceholderView: View {
    
    let imageName: String
    let title: String
    let message: String
    let buttonTitle: String
    
    var onButtonTap: (() -> Void)?
    
    init(
        imageName: String = "",
        title: String = "",
        message: String = "",
        buttonTitle: String = "",
        onButtonTap: (() -> Void)? = nil
    ) {
        self.imageName = imageName
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.onButtonTap = onButtonTap
    }
    
    var body: some View {
        VStack(spacing: 20) {
            
            if imageName != "" {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
            }
            
            VStack(spacing: 10) {
                Text(title)
                    .fontCustom(size: 17, weight: .medium)
                    .foregroundColor(Color.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                if message != "" {
                    Text(message)
                        .fontCustom(size: 16, weight: .regular)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                }
                
            }
            
            Button {
                onButtonTap?()
            } label: {
                Text(buttonTitle)
                    .fontCustom(size: 17, weight: .semibold)
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 30)
                    .frame(height: 45)
                    .background(
                        Capsule()
                            .fill(Color.blue)
                    )
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        
    }
}

#Preview {
    PlaceholderView(
        imageName: "wifi.slash",
        title: "No Internet Connection",
        message: "Please check your internet connection",
        buttonTitle: "Retry"
    )
}
