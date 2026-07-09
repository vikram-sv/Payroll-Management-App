//
//  PayrollRepositoryImpl.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//

import Foundation
import CoreData

final class PayrollRepositoryImpl: PayrollRepository {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }
    
    func savePayroll(_ payroll: Payroll) throws {
        
        let payrollEntity = PayrollEntity(context: context)
        
        payrollEntity.id = payroll.id
        payrollEntity.createdDate = payroll.createdDate
        
        for employee in payroll.employees {
            
            let employeeEntity = EmployeeEntity(context: context)
            
            employeeEntity.id = employee.id
            employeeEntity.name = employee.name
            employeeEntity.wages = employee.wages
            employeeEntity.isExempt = employee.isExempt
            employeeEntity.payroll = payrollEntity

        }
        
        try context.save()
        
    }
    
    func fetchPayrolls() throws -> [Payroll] {

        let request: NSFetchRequest<PayrollEntity> = PayrollEntity.fetchRequest()

        let payrollEntities = try context.fetch(request)

        return payrollEntities.map { payrollEntity in

            let employees = (payrollEntity.employees as? Set<EmployeeEntity>)?
                .map { employeeEntity in

                    Employee(
                        id: employeeEntity.id ?? UUID(),
                        name: employeeEntity.name ?? "",
                        wages: employeeEntity.wages,
                        isExempt: employeeEntity.isExempt
                    )

                } ?? []

            return Payroll(
                id: payrollEntity.id ?? UUID(),
                createdDate: payrollEntity.createdDate ?? Date(),
                employees: employees
            )

        }

    }
    
    func deletePayroll(id: UUID) throws {

        let request: NSFetchRequest<PayrollEntity> = PayrollEntity.fetchRequest()

        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        guard let payroll = try context.fetch(request).first else {
            return
        }

        context.delete(payroll)

        try context.save()
    }
    
    func updatePayroll(_ payroll: Payroll) throws {
        
        let request: NSFetchRequest<PayrollEntity> = PayrollEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", payroll.id as CVarArg)
        
        guard let payrollEntity = try context.fetch(request).first else {
            throw PayrollRepositoryError.payrollNotFound
        }
        
        // MARK: REMOVE OLD EMPLOYEES
        if let existingEmployees = payrollEntity.employees as? Set<EmployeeEntity> {
            for employeeEntity in existingEmployees {
                context.delete(employeeEntity)
            }
        }
        
        // MARK: ADD CURRENT EMPLOYEES
        for employee in payroll.employees {
            let employeeEntity = EmployeeEntity(context: context)
            employeeEntity.id = employee.id
            employeeEntity.name = employee.name
            employeeEntity.wages = employee.wages
            employeeEntity.isExempt = employee.isExempt
            employeeEntity.payroll = payrollEntity
        }
        
        try context.save()
    }
    
}
