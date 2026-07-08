//
//  HideKeyboard+Extension.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import Foundation
import SwiftUI

func hideKeyboard() {
    UIApplication.shared
        .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
