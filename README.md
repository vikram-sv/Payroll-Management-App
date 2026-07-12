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
├── AppData
│   ├── PayrollManagementApp.swift
│   └── Assets.xcassets
│
└── AppFiles
    │
    ├── Data
    │   ├── CoreData
    │   └── Repository
    │
    ├── Domain
    │   ├── CoreDataModels
    │   │   └── PayrollModel.xcdatamodeld
    │   ├── Models
    │   └── Repository
    │
    ├── Presentation
    │   ├── Components
    │   ├── Modifiers
    │   ├── ViewModels
    │   ├── Views
    │   │   └── ContentView.swift
    │   └── ViewState
    │
    ├── Service
    │   └── UITestDataService.swift
    │
    └── Utilities
        ├── Constants
        ├── Extensions
        ├── Fonts
        ├── Formatters
        └── Helpers
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

Contains the application's business models, repository contracts, and Core Data model definitions.

Responsibilities include:

- Business entities
- Repository protocols
- Business rules
- Core Data model schema (`PayrollModel.xcdatamodeld`)

This layer is independent of SwiftUI.

---

## Data Layer

Implements repository protocols and manages data persistence using Core Data.

Responsibilities include:

- CRUD operations
- Mapping Core Data entities to domain models
- Local persistence

---

## Service Layer

Contains supporting services used for auxiliary functionality.

Includes:

- `UITestDataService` — provides seeded data for UI test scenarios

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

Mock objects are provided via the `Mocks/` directory (e.g., `MockPayrollRepository`).

Run Unit Tests

```
⌘ + U
```

---

## UI Tests

UI automation validates critical user flows including:

- Splash Screen
- Payroll List
- Create Payroll
- Payroll Details
- Edit Payroll
- Delete Payroll

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
