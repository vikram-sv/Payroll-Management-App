//
//  EditPayrollView.swift
//  PayrollManagement
//
//  Created by Vikram Sukumaran on 09/07/26.
//

import SwiftUI

struct EditPayrollView: View {
    
    @StateObject var editPayrollVM: EditPayrollViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showAddEmployeeSheet: Bool = false
    @State private var showAlertUpdateError: Bool = false
    
    var onUpdate: ((Payroll) -> Void)? = nil
    
    init(
        payroll: Payroll,
        onUpdate: ((Payroll) -> Void)? = nil
    ) {
        _editPayrollVM = StateObject(wrappedValue: EditPayrollViewModel(payroll: payroll))
        self.onUpdate = onUpdate
    }
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - HEADER
                header
                
                HStack(alignment: .top, spacing: 10) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.system(size: 14))
                            .foregroundColor(.red)

                        Image(systemName: "circle.fill")
                            .font(.system(size: 8))
                            .foregroundColor(.red)
                    }
                    .padding(.top, 3)

                    Text("Tap an employee to update wages or tax exemption status.")
                        .fontCustom(size: 15, weight: .regular)
                        .foregroundColor(Color.AppColors.ThemeNavy)
                        .multilineTextAlignment(.leading)

                    Spacer()
                }
                
                if editPayrollVM.employees.isEmpty {
                   
                    PlaceholderView(
                        imageName: "person.crop.circle",
                        title: "No Employees",
                        message: "Tap the button below to add a new employee",
                        buttonTitle: "Add Employee",
                        onButtonTap: {
                            editPayrollVM.selectedEmployee = nil
                            showAddEmployeeSheet = true
                        }
                    )
                    
                } else {
                    
                    VStack(spacing: 15) {
                        ScrollView(showsIndicators: true) {
                            LazyVStack(spacing: 15) {
                                ForEach(editPayrollVM.employees) { employee in
                                    EmployeeCardView(
                                        employee: employee,
                                        onDelete: { employee in
                                            editPayrollVM.removeEmployee(employee)
                                        }
                                    )
                                    .onTapGesture {
                                        // MARK: EDIT EXISTING EMPLOYEE
                                        editPayrollVM.selectedEmployee = employee
                                        showAddEmployeeSheet = true
                                    }
                                }
                            }
                            .padding([.top, .bottom], 20)
                        }
                        
                        addEmployeeButton
                        
                        updatePayrollButton
                        
                    }
                }
                
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddEmployeeSheet, content: {
            AddEmployeeSheet(employeeToEdit: editPayrollVM.selectedEmployee) { employee in
                let validatedEmployee = try editPayrollVM.validateEmployee(
                    id: employee.id,
                    name: employee.name,
                    wages: employee.wages,
                    isExempt: employee.isExempt
                )
                
                if editPayrollVM.selectedEmployee != nil {
                    editPayrollVM.updateEmployee(validatedEmployee)
                } else {
                    editPayrollVM.addEmployee(validatedEmployee)
                }
            }
        })
        .toast(
            isPresented: $editPayrollVM.showToast,
            message: editPayrollVM.toastMessage ?? "Please fill all the fields"
        )
        .alert(isPresented: $showAlertUpdateError) {
            Alert(
                title: Text("Something went wrong"),
                message: Text("Please, try again later"),
                dismissButton: .destructive(Text("OK"))
            )
        }
        
    }
    
}

#Preview {
    EditPayrollView(
        payroll: Payroll(
            id: UUID(),
            createdDate: Date(),
            employees: [Employee(
                id: UUID(),
                name: "Vikram",
                wages: 12000,
                isExempt: true
            )]
        )
    )
}

extension EditPayrollView {
    
    private var header: some View {
        HStack(spacing: 15) {
            
            HeaderView(headerName: "Edit Payroll")
            
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
            editPayrollVM.selectedEmployee = nil
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
    }
    
    private var updatePayrollButton: some View {
        Button {
            // MARK: UPDATE ACTION
            do {
                let updatedPayroll = try editPayrollVM.updatePayroll()
                onUpdate?(updatedPayroll)
                dismiss()
            } catch {
                self.showAlertUpdateError = true
            }
        } label: {
            Text("Update Payroll")
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

