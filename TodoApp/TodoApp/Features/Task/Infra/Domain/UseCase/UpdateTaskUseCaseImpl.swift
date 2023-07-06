//
//  UpdateTaskUseCaseImpl.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Impl UpdateTaskUseCase

class UpdateTaskUseCaseImpl: UpdateTaskUseCase {
    private let repository: UpdateTaskRepository

    init(repository: UpdateTaskRepository) {
        self.repository = repository
    }

    func toogleTaskStatus(_ taskEntity: TaskEntity, complete: @escaping (Error?) -> Void) {
        repository.changeTaskStatus(id: taskEntity.id, status: taskEntity.status.toggle(), complete: complete)
    }

    func update(_ taskEntity: TaskEntity, title: String, description: String?, dateTime: Date, category: CategoryEntity, priority: Int, status: TaskStatus, complete: @escaping (Error?) -> Void) {
        repository.update(id: taskEntity.id, title: title, description: description, dateTime: dateTime, category: category, priority: priority, status: status, complete: complete)
    }
}
