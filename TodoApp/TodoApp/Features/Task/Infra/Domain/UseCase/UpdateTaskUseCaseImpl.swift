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
}
