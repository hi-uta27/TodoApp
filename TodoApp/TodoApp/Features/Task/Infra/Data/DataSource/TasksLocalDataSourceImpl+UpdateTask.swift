//
//  TasksLocalDataSourceImpl+UpdateTask.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Impl UpdateTaskLocalDataSource

extension TasksLocalDataSourceImpl {
    func changeTaskStatus(id: String, status: TaskStatus, complete: @escaping (Error?) -> Void) {
        guard let model = queryAll(returningClass: RTaskModel.self)?.where({ $0.id.like(id) }).first else { return }
        let task = RTaskModel(entity: model)
        task.status = status
        save(entity: task, update: true) { result in
            switch result {
            case .success:
                complete(nil)
            case .failure(let failure):
                complete(failure)
            }
        }
    }

    func update(id: String, title: String, description: String?, dateTime: Date, category: CategoryEntity, priority: Int, status: TaskStatus, complete: @escaping (Error?) -> Void) {
        guard let model = queryAll(returningClass: RTaskModel.self)?.where({ $0.id.like(id) }).first else { return }
        let task = RTaskModel(id: model.id, title: title, descriptions: description, startTime: dateTime, priority: priority, status: status, category: category)
        save(entity: task, update: true) { result in
            switch result {
            case .success:
                complete(nil)
            case .failure(let failure):
                complete(failure)
            }
        }
    }
}
