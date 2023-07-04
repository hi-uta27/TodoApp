//
//  UpdateTaskRepository.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Func updateTask with: TaskEntity -> Error?

protocol UpdateTaskRepository {
    func changeTaskStatus(id: String, status: TaskStatus, complete: @escaping (Error?) -> Void)
}
