//
//  UpdateTaskRepositoryImpl.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Impl UpdateTaskRepository

class UpdateTaskRepositoryImpl: UpdateTaskRepository {
    private let localDataSource: UpdateTaskLocalDataSource

    init(localDataSource: UpdateTaskLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func changeTaskStatus(id: String, status: TaskStatus, complete: @escaping (Error?) -> Void) {
        localDataSource.changeTaskStatus(id: id, status: status, complete: complete)
    }

    func update(id: String, title: String, description: String?, dateTime: Date, category: CategoryEntity, priority: Int, status: TaskStatus, complete: @escaping (Error?) -> Void) {
        localDataSource.update(id: id, title: title, description: description, dateTime: dateTime, category: category, priority: priority, status: status, complete: complete)
    }
}
