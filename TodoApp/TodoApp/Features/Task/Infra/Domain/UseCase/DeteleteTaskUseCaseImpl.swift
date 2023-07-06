//
//  DeteleteTaskUseCaseImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import Foundation

class DeteleteTaskUseCaseImpl: DeleteTaskUseCase {
    private let repository: DeleteTaskRepository

    init(repository: DeleteTaskRepository) {
        self.repository = repository
    }

    func deleteTask(_ taskEntity: TaskEntity, completed: @escaping (Error?) -> Void) {
        repository.deleteTask(id: taskEntity.id, completed: completed)
    }
}
