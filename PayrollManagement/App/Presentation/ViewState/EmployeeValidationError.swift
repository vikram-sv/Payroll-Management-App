enum EmployeeValidationError: Error {
    case emptyName
    case invalidWages

    var message: String {
        switch self {
        case .emptyName:
            return "Please enter employee name."
        case .invalidWages:
            return "Please enter valid wages."
        }
    }
}