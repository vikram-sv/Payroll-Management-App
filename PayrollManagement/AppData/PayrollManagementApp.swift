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
    
//    let persistenceController = PersistenceController.shared
    
    init() {
        UITestDataService().prepareApp()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
//                .environment(\.managedObjectContext,
//                              persistenceController.container.viewContext)
        }
    }
}
