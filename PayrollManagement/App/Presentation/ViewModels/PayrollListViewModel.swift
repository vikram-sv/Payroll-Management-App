//
//  PayrollListViewModel.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//

import Swift
import Foundation
import Combine

final class PayrollListViewModel: ObservableObject {
    
    @Published var payrollLists: [Payroll] = []
    @Published var viewState: PayrollListViewState = .loading
    @Published var selectedPayroll: Payroll?
    
    private let repository: PayrollRepository
    
    init(repository: PayrollRepository = PayrollRepositoryImpl()) {
        self.repository = repository
    }
    
    /// `After creating the payroll and tap save after dismissing that sheet need to call this fetch payroll to show the lists`
    func fetchPayrolls() {
        viewState = .loading
        
        do {
            payrollLists = try repository.fetchPayrolls()
            
            if payrollLists.isEmpty {
                viewState = .empty
            } else {
                viewState = .loaded
            }
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }
    
    func deletePayroll(_ payroll: Payroll) {

        do {
            
            try repository.deletePayroll(id: payroll.id)
            payrollLists.removeAll { $0.id == payroll.id }
            viewState = payrollLists.isEmpty ? .empty : .loaded

        } catch {
            viewState = .error(error.localizedDescription)
        }
    }
    
}
