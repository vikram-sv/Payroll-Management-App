//
//  PayrollDetailViewModel.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 08/07/26.
//

import Foundation
import Combine

final class PayrollDetailViewModel: ObservableObject {
    
    let payroll: Payroll
    
    init(payroll: Payroll) {
        self.payroll = payroll
    }
    
}
