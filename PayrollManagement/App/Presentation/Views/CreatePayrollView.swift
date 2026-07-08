//
//  CreatePayrollView.swift
//  Payroll Management
//
//  Created by Vikram Sukumaran on 07/07/2026.
//

import SwiftUI

struct CreatePayrollView: View {
    
    @StateObject var createPayrollVM: CreatePayrollViewModel = CreatePayrollViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var showAddEmployeeSheet: Bool = false
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - HEADER
                header
                
                
                if createPayrollVM.employees.isEmpty {
                   
                    PlaceholderView(
                        imageName: "person.crop.circle",
                        title: "No Employees",
                        message: "Tap the button below to add a new employee",
                        buttonTitle: "Add Employee",
                        onButtonTap: {
                            showAddEmployeeSheet = true
                        }
                    )
                    
                } else {
                    
                    VStack(spacing: 15) {
                        ScrollView(showsIndicators: true) {
                            LazyVStack(spacing: 15) {
                                ForEach(createPayrollVM.employees) { employee in
                                    EmployeeCardView(employee: employee)
                                }
                            }
                            .padding([.top, .bottom], 20)
                        }
                        
                        addEmployeeButton
                        
                        savePayrollButton
                    }
                }
                
                
                
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddEmployeeSheet, onDismiss: {
            
        }, content: {
            AddEmployeeSheet { employee in
                createPayrollVM.addEmployee(employee)
            }
        })
        
    }
    
}

#Preview {
    CreatePayrollView()
}

extension CreatePayrollView {
    
    private var header: some View {
        HStack(spacing: 15) {
            HeaderView(headerName: "Create Payroll")
            
            Button {
                // MARK: SCREEN DISMISS ACTION
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color.black)
                    .padding(10)
                    .contentShape(Rectangle())
            }
        }
    }
    
    
    private var addEmployeeButton: some View {
        Button {
            // MARK: ADD MORE NEW EMPLOYEE
            showAddEmployeeSheet = true
        } label: {
            Text("Add Employee")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color.white)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .contentShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    private var savePayrollButton: some View {
        Button {
            // MARK: SAVE ACTION
            
        } label: {
            Text("Save Payroll")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color.white)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(10)
                .contentShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    
}
