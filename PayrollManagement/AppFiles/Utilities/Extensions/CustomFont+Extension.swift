//
//  CustomFont+Edxtension.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//

import Foundation
import SwiftUI

extension View {
    
    func fontCustom(size: CGFloat, weight: Font.Weight) -> some View {
        let fontName: String
        
        switch weight {
        case .thin:
            fontName = "HankenGrotesk-Thin"
        case .light:
            fontName = "HankenGrotesk-Light"
        case .regular:
            fontName = "HankenGrotesk-Regular"
        case .medium:
            fontName = "HankenGrotesk-Medium"
        case .semibold:
            fontName = "HankenGrotesk-SemiBold"
        case .bold:
            fontName = "HankenGrotesk-Bold"
        default:
            fontName = "HankenGrotesk-Regular" // fallback
        }
        
        return self
            .font(.custom(fontName, size: size))
            .environment(\.sizeCategory, .large)
    }
}

// For Text concatenation (no environment here)
extension Text {
    func CustomFontText(size: CGFloat, weight: Font.Weight) -> Text {
        let fontName: String
        switch weight {
        case .thin: fontName = "HankenGrotesk-Thin"
        case .light: fontName = "HankenGrotesk-Light"
        case .regular: fontName = "HankenGrotesk-Regular"
        case .medium: fontName = "HankenGrotesk-Medium"
        case .semibold: fontName = "HankenGrotesk-SemiBold"
        case .bold: fontName = "HankenGrotesk-Bold"
        default: fontName = "HankenGrotesk-Regular"
        }
        
        return self.font(.custom(fontName, size: size))
    }
}
