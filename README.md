# Payroll Management

A modern payroll management application built with **SwiftUI** following **MVVM** and **Clean Architecture** principles. The application enables users to create, manage, edit, and review payrolls while automatically calculating employee taxes and net wages. All data is persisted locally using **Core Data**.

---

# Features

- Create and manage payrolls
- Add, edit, and remove employees
- Edit existing payrolls
- Delete payrolls
- Automatic payroll tax calculation
- Employee wage summary
- Local data persistence using Core Data
- Reusable SwiftUI components
- Unit and UI test coverage

---

# Technology Stack

| Technology | Purpose |
|------------|---------|
| Swift 6 | Programming Language |
| SwiftUI | User Interface |
| MVVM | Presentation Architecture |
| Repository Pattern | Data Abstraction |
| Core Data | Local Persistence |
| XCTest | Unit Testing |
| XCUITest | UI Testing |

---

# Project Structure

```
PayrollManagement
│
├── App
│   ├── PayrollManagementApp.swift
│   ├── ContentView.swift
│   └── SplashView.swift
│
├── Data
│   ├── CoreData
│   └── Repository
│
├── Domain
│   ├── Models
│   └── Repository
│
├── Presentation
│   ├── Components
│   ├── Modifiers
│   ├── ViewModels
│   ├── Views
│   └── ViewState
│
├── Utilities
│   ├── Extensions
│   ├── Fonts
│   ├── Formatters
│   ├── Helpers
│   └── TaxCalculator
│
└── Assets
```

---

# Architecture

The project follows **MVVM** combined with the **Repository Pattern** to maintain a clear separation of concerns.

```
Presentation Layer
        │
        ▼
    ViewModel
        │
        ▼
 Repository Layer
        │
        ▼
   Core Data Store
```

## Presentation Layer

Responsible for rendering the user interface using SwiftUI.

Includes:

- Views
- ViewModels
- Reusable Components
- View States

The ViewModel exposes observable state and contains presentation logic while remaining independent of persistence.

---

## Domain Layer

Contains the application's business models and repository contracts.

Responsibilities include:

- Business entities
- Repository protocols
- Business rules

This layer is independent of SwiftUI and Core Data.

---

## Data Layer

Implements repository protocols and manages data persistence using Core Data.

Responsibilities include:

- CRUD operations
- Mapping Core Data entities to domain models
- Local persistence

---

# Tax Calculation

The application follows the following payroll rule:

| Condition | Tax |
|-----------|-----|
| Wages ≤ 1000 | 0% |
| Wages > 1000 and Employee is Exempt | 0% |
| Wages > 1000 and Employee is Not Exempt | 5% |

Net wages are calculated automatically after tax deduction.

---

# Running the Project

## Requirements

- macOS
- Xcode 26 or later
- iOS 26 Simulator (or later)

## Installation

Clone the repository

```bash
git clone https://github.com/vikram-sv/Payroll-Management-App.git
```

Navigate to the project

```bash
cd PayrollManagement
```

Open the project

```bash
open PayrollManagement.xcodeproj
```

Select an iPhone simulator and run the application.

---

# Testing

The project includes both **Unit Tests** and **UI Tests**.

## Unit Tests

Business logic is covered through unit tests for:

- Tax Calculator
- CreatePayrollViewModel
- EditPayrollViewModel
- PayrollListViewModel
- Repository Layer

Run Unit Tests

```
⌘ + U
```

---

## UI Tests

UI automation validates critical user flows including:

- Payroll List
- Create Payroll
- Employee Creation
- Payroll Details
- Edit Payroll
- Delete Payroll
- Employee Deletion

---

# Design Principles

The project was designed with the following principles:

- Single Responsibility Principle (SRP)
- Separation of Concerns
- Dependency Inversion
- Reusable UI Components
- Maintainable Folder Structure
- Testable Business Logic

---

# Future Improvements

Potential enhancements include:

- Dependency Injection Container
- Cloud Synchronization
- Search and Filtering
- Payroll Reports
- CSV / PDF Export
- Localization
- Accessibility Improvements
- Enhanced Error Handling
- Background Data Synchronization
- CI/CD Pipeline using GitHub Actions or Xcode Cloud

---

# Author

**Vikram Sukumaran**
