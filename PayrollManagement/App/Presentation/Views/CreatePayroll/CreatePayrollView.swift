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
    @State private var showAlertFetchingError: Bool = false
    
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
                        accessibilityIdentifierForView: "AddEmployeesPlaceHolder",
                        onButtonTap: {
                            showAddEmployeeSheet = true
                        }
                    )
                    
                } else {
                    
                    VStack(spacing: 15) {
                        ScrollView(showsIndicators: true) {
                            LazyVStack(spacing: 15) {
                                ForEach(createPayrollVM.employees) { employee in
                                    EmployeeCardView(
                                        employee: employee,
                                        onDelete: { employee in
                                            createPayrollVM.removeEmployee(employee)
                                        }
                                    )
                                    .onTapGesture {
                                        // MARK: EDIT EXISTING EMPLOYEE
                                        createPayrollVM.selectedEmployee = employee
                                        showAddEmployeeSheet = true
                                    }
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
        .sheet(isPresented: $showAddEmployeeSheet, content: {
            AddEmployeeSheet(employeeToEdit: createPayrollVM.selectedEmployee) { employee in
                let validatedEmployee = try createPayrollVM.validateEmployee(
                    id: employee.id,
                    name: employee.name,
                    wages: employee.wages,
                    isExempt: employee.isExempt
                )
                
                if createPayrollVM.selectedEmployee != nil {
                    createPayrollVM.updateEmployee(validatedEmployee)
                } else {
                    createPayrollVM.addEmployee(validatedEmployee)
                }
            }
        })
        .toast(
            isPresented: $createPayrollVM.showToast,
            message: createPayrollVM.toastMessage ?? "Please fill all the fields"
        )
        .alert(isPresented: $showAlertFetchingError) {
            Alert(
                title: Text("Something went wrong"),
                message: Text("Please, try again later"),
                dismissButton: .destructive(Text("OK"))
            )
        }
        
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
                    .foregroundColor(.primary)
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
                .fontCustom(size: 16, weight: .semibold)
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.AppColors.ThemeNavy)
                .cornerRadius(10)
                .contentShape(RoundedRectangle(cornerRadius: 10))
        }
        .accessibilityIdentifier("AddEmployeeButton")
    }
    
    private var savePayrollButton: some View {
        Button {
            // MARK: SAVE ACTION
            do {
                try createPayrollVM.savePayroll()
                dismiss()
            } catch {
                self.showAlertFetchingError = true
            }
        } label: {
            Text("Save Payroll")
                .fontCustom(size: 16, weight: .semibold)
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.AppColors.ThemeGreen)
                .cornerRadius(10)
                .contentShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    
}
