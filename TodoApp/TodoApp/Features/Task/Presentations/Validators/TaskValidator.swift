//
//  TaskValidator.swift
//  TodoApp
//
//  Created by Heligate on 16/06/2023.
//

import Foundation

enum TaskValidationError: LocalizedError {
    case emptyTitle
    case emptyStartTime
    case emptyCategory
    case emptyPriority
    case startTimeError
}

extension TaskValidationError {
    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Please enter a Task title"
        case .emptyStartTime:
            return "No Start Time have been selected yet"
        case .emptyCategory:
            return "No Category have been selected yet"
        case .emptyPriority:
            return "No Priority have been selected yet"
        case .startTimeError:
            return "Start Time must be greater than or equal to current date"
        }
    }
}

enum TaskValidator {
    static func validateData(title: String?, description: String?, startTime: Date?, currentDate: Date, category: CategoryEntity?, priority: Int?) throws
        -> (title: String, description: String?, startTime: Date, category: CategoryEntity, priority: Int)
    {
        do {
            let title = try validateTitle(title)
            let description = try validateDescription(description)
            let startTime = try validateStartTime(startTime, currentDate: currentDate)
            let category = try validateCategory(category)
            let priority = try validatePriority(priority)
            return (title, description, startTime, category, priority)
        } catch {
            throw error
        }
    }

    static func validateTitle(_ title: String?) throws -> String {
        if let title = title, !title.isEmpty {
            return title
        } else {
            throw TaskValidationError.emptyTitle
        }
    }

    static func validateDescription(_ description: String?) throws -> String? {
        return description
    }

    private static func validateStartTime(_ startTime: Date?, currentDate: Date) throws -> Date {
        guard let startTime = startTime else { throw TaskValidationError.emptyStartTime }
        if startTime >= currentDate {
            return startTime
        } else {
            throw TaskValidationError.startTimeError
        }
    }

    private static func validateCategory(_ category: CategoryEntity?) throws -> CategoryEntity {
        if let category = category {
            return category
        } else {
            throw TaskValidationError.emptyCategory
        }
    }

    private static func validatePriority(_ priority: Int?) throws -> Int {
        if let priority = priority {
            return priority
        } else {
            throw TaskValidationError.emptyPriority
        }
    }
}
