//
//  TasksLocalDataSourceImpl+CreateTask.swift
//  TodoApp
//
//  Created by Heligate on 28/06/2023.
//

import Foundation

extension TasksLocalDataSourceImpl {
    func createTask(_ task: RTaskModel, completed: @escaping (Result<RTaskModel, Error>) -> Void) {
        save(entity: task, update: false) { result in
            switch result {
            case .success:
                completed(.success(task))
            case .failure(let failure):
                completed(.failure(failure))
            }
        }
    }
}
