//
//  PersistantController.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//

import Foundation
import CoreData

final class PersistenceController {

    static let shared = PersistenceController()

    let container: NSPersistentContainer

    private init() {

        container = NSPersistentContainer(name: "PayrollModel")

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data: \(error.localizedDescription)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
