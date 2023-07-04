//
//  ReadTaskUseCaseImpl.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Impl ReadTaskUseCase

class ReadTaskUseCaseImpl: ReadTaskUseCase {
    private let repository: ReadTaskRepository

    init(repository: ReadTaskRepository) {
        self.repository = repository
    }

    func readTask(filter: TaskFilter, completed: @escaping (Result<[TaskEntity]?, Error>) -> Void) {
        repository.readTask(date: filter.date, keyword: filter.keyword, completed: completed)
    }
}
