//
//  CategoryValidations.swift
//  TodoApp
//
//  Created by Heligate on 13/06/2023.
//

import Foundation

enum CategoryValidationsError: LocalizedError {
    case emptyName
    case emptyIcon
    case emptyColor
}

extension CategoryValidationsError {
    var errorDescription: String? {
        return localizedDescription
    }

    var localizedDescription: String {
        switch self {
        case .emptyName:
            return "Please enter a Category Name"
        case .emptyIcon:
            return "No Icon have been selected yet"
        case .emptyColor:
            return "No Color have been selected yet"
        }
    }
}

enum CategoryValidator {
    static func validateData(name: String?, icon: String?, color: String?) throws -> (name: String, icon: String, color: String) {
        do {
            let name = try validateName(name)
            let icon = try validateIcon(icon)
            let color = try validateColor(color)
            return (name, icon, color)
        } catch {
            throw error
        }
    }

    private static func validateName(_ name: String?) throws -> String {
        if let name = name, !name.isEmpty {
            return name
        } else {
            throw CategoryValidationsError.emptyName
        }
    }

    private static func validateIcon(_ icon: String?) throws -> String {
        if let icon = icon, !icon.isEmpty {
            return icon
        } else {
            throw CategoryValidationsError.emptyIcon
        }
    }

    private static func validateColor(_ color: String?) throws -> String {
        if let color = color, !color.isEmpty {
            return color
        } else {
            throw CategoryValidationsError.emptyColor
        }
    }
}
