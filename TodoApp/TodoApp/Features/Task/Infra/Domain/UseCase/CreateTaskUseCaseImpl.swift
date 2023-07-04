//
//  CreateTaskUseCaseImpl.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import Foundation

class CreateTaskUseCaseImpl: CreateTaskUseCase {
    private let repository: CreateTaskRepository

    init(repository: CreateTaskRepository) {
        self.repository = repository
    }

    func createTask(title: String, description: String?, startTime: Date, category: CategoryEntity, priority: Int, completed: @escaping (Result<TaskEntity, Error>) -> Void) {
        repository.createTask(title: title, description: description, startTime: startTime, category: category, priority: priority, completed: completed)
    }
}
