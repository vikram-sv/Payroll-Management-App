//
//  UITestDataService.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 10/07/26.
//

import Foundation

final class UITestDataService {

    private let repository: PayrollRepository

    init(repository: PayrollRepository = PayrollRepositoryImpl()) {
        self.repository = repository
    }

    func prepareApp() {

        if ProcessInfo.processInfo.arguments.contains("UITesting") {
            try? repository.deleteAllPayrolls()
        } else if ProcessInfo.processInfo.arguments.contains("UITestingWithData") {
            
            try? repository.deleteAllPayrolls()

            let employees = [
                Employee(
                    id: UUID(),
                    name: "Vikram",
                    wages: 1500,
                    isExempt: false
                ),
                Employee(
                    id: UUID(),
                    name: "John",
                    wages: 900,
                    isExempt: true
                )
            ]

            let payroll = Payroll(
                id: UUID(),
                createdDate: Date(),
                employees: employees
            )

            try? repository.savePayroll(payroll)
        }

    }

}
