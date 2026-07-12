//
//  PayrollManagementApp.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI
import CoreData

@main
struct PayrollManagementApp: App {
    
    init() {
        UITestDataService().prepareApp()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
