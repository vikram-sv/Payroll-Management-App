//
//  PayrollListView.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct PayrollListView: View {
    
    @State private var showCreatePayroll: Bool = false

    private let summaries: [PayrollSummary] = [
        PayrollSummary(
            createdDate: DateFormatter.payrollInput.date(from: "07 Jul 2026") ?? Date(),
            employeeCount: 3,
            total: 4800
        )
    ]

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - HEARDER
                HeaderView(headerName: "Payroll Lists")

                // MARK: - PAYROLL LISTS
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 15) {
                        ForEach(summaries.indices, id: \.self) { index in
                            PayrollSummaryCardView(detail: summaries[index])
                        }
                    }
                    .padding(.top, 20)
                }
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            // MARK: - CREATE BUTTON
            createButton
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showCreatePayroll) {
            CreatePayrollView()
        }
        
    }
}


#Preview {
    PayrollListView()
}

extension PayrollListView {
    
    private var createButton: some View {
        Button {
            // MARK: CREATE PAYROLL SCREEN TAP ACTION
            showCreatePayroll = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 35, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.green)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(40)
    }
    
}
