//
//  PayrollListView.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct PayrollListView: View {
    
    @StateObject var payrollListVM: PayrollListViewModel = PayrollListViewModel()
    
    @State private var showCreatePayroll: Bool = false
    @State private var showDeleteConfirmation: Bool = false

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - HEADER
                HeaderView(headerName: "Payroll Hub")
                
                switch payrollListVM.viewState {

                case .loading:
                    ProgressView()

                case .empty:
                    PlaceholderView(
                        imageName: "person.2.fill",
                        title: "No Payrolls",
                        message: "Tap the button below to add a new payroll",
                        buttonTitle: "Add Payroll",
                        onButtonTap: {
                            showCreatePayroll = true
                        }
                    )

                case .loaded:
                    // MARK: - PAYROLL LISTS
                    ScrollView(showsIndicators: true) {
                        VStack(spacing: 15) {
                            ForEach(payrollListVM.payrollLists) { payroll in
                                NavigationLink {
                                    PayrollDetailView(payroll: payroll)
                                } label: {
                                    PayrollSummaryCardView(
                                        detail: payroll,
                                        onDelete: { payroll in
                                            payrollListVM.selectedPayroll = payroll
                                            showDeleteConfirmation = true
                                        }
                                    )
                                }
                            }
                        }
                        .padding(.top, 20)
                    }

                case .error(let message):
                    PlaceholderView(
                        imageName: "exclamationmark.triangle",
                        title: "Something went wrong",
                        message: message,
                        buttonTitle: "Try Again",
                        onButtonTap: {
                            payrollListVM.fetchPayrolls()
                        }
                    )
                }
                
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            // MARK: - CREATE BUTTON
            if !payrollListVM.payrollLists.isEmpty {
                createButton
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
        .fullScreenCover(isPresented: $showCreatePayroll, onDismiss: {
            payrollListVM.fetchPayrolls()
        }) {
            CreatePayrollView()
        }
        .onAppear {
            payrollListVM.fetchPayrolls()
        }
        .appPopup(isPresented: $showDeleteConfirmation) {
            AppPopup(
                title: "Delete Payroll",
                message: "Are you sure you want to delete this payroll?",
                primaryTitle: "Delete",
                secondaryTitle: "Cancel",
                primaryAction: {
                    guard let payroll = payrollListVM.selectedPayroll else { return }
                    
                    payrollListVM.deletePayroll(payroll)
                    
                    showDeleteConfirmation = false
                    payrollListVM.selectedPayroll = nil
                },
                secondaryAction: {
                    showDeleteConfirmation = false
                }
            )
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
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .bold))
                
                Text("Create New Payroll")
                    .fontCustom(size: 16, weight: .bold)
                    .foregroundColor(Color.white)
            }
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color.black.opacity(0.9))
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(30)
        .padding(.bottom, 20)
    }
    
}
