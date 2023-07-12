//
//  UserValidator.swift
//  TodoApp
//
//  Created by TaHieu on 7/11/23.
//

import Foundation

enum UserValidationError: LocalizedError {
    case emptyEmail
    case invalidEmail
    case emptyPassword
    case emptyConfirmPassword
    case passwordNotEqual
}

extension UserValidationError {
    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Please enter a Email"
        case .invalidEmail:
            return "Email is not correct"
        case .emptyPassword:
            return "Please enter a Password"
        case .emptyConfirmPassword:
            return "Please enter a Confirm Password"
        case .passwordNotEqual:
            return "Password is not equal with Confirm Password"
        }
    }
}

enum UserValidator {
    static func validateData(email: String?, password: String?, confirmPassword: String?) throws -> (userName: String, password: String) {
        do {
            let userName = try validateEmail(email)
            let password = try validatePassword(password)
            let confirmPassword = try validateConfirmPassword(confirmPassword)
            if password == confirmPassword {
                return (userName, password)
            } else {
                throw UserValidationError.passwordNotEqual
            }
        } catch {
            throw error
        }
    }

    static func validateData(email: String?, password: String?) throws -> (userName: String, password: String) {
        do {
            let userName = try validateEmail(email)
            let password = try validatePassword(password)
            return (userName, password)
        } catch {
            throw error
        }
    }

    private static func validateEmail(_ email: String?) throws -> String {
        guard let email = email, !email.isEmpty else { throw UserValidationError.emptyEmail }
        if email.isValidEmail {
            return email
        } else {
            throw UserValidationError.invalidEmail
        }
    }

    private static func validatePassword(_ password: String?) throws -> String {
        guard let password = password, !password.isEmpty else { throw UserValidationError.emptyPassword }
        return password
    }

    private static func validateConfirmPassword(_ confirmPassword: String?) throws -> String {
        guard let confirmPassword = confirmPassword, !confirmPassword.isEmpty else { throw UserValidationError.emptyConfirmPassword }
        return confirmPassword
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: self)
    }
}
