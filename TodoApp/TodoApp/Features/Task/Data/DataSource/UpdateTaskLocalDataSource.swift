//
//  UpdateTaskLocalDataSource.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Func updateTask with: RTaskModel -> Error?

protocol UpdateTaskLocalDataSource {
    func changeTaskStatus(id: String, status: TaskStatus, complete: @escaping (Error?) -> Void)
    func update(id: String, title: String, description: String?, dateTime: Date,
                category: CategoryEntity, priority: Int, status: TaskStatus, complete: @escaping (Error?) -> Void)
}
