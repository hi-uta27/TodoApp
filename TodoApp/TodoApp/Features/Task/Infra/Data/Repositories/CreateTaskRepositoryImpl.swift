//
//  CreateTaskRepositoryImpl.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import Foundation

class CreateTaskRepositoryImpl: CreateTaskRepository {
    private let localDataSource: CreateTaskLocalDataSource

    init(localDataSource: CreateTaskLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func createTask(title: String, description: String?, startTime: Date, category: CategoryEntity, priority: Int, completed: @escaping (Result<TaskEntity, Error>) -> Void) {
        let task = RTaskModel(title: title, startTime: startTime, priority: priority, category: category)

        localDataSource.createTask(task) { result in
            switch result {
            case .success(let entity):
                completed(.success(entity))
            case .failure(let failure):
                completed(.failure(failure))
            }
        }
    }
}
