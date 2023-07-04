//
//  TaskStatus+Value.swift
//  TodoApp
//
//  Created by Heligate on 27/06/2023.
//

import Foundation

extension TaskStatus {
    func toggle() -> Self {
        switch self {
        case .todo:
            return .completed
        case .completed:
            return .todo
        }
    }

    var description: String {
        switch self {
        case .todo:
            return "Todo"
        case .completed:
            return "Completed"
        }
    }
}
