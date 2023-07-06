//
//  TasksLocalDataSource+DeleteTask.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import Foundation

extension TasksLocalDataSourceImpl {
    func deleteTask(id: String, completed: @escaping (Error?) -> Void) {
        guard let model = queryAll(returningClass: RTaskModel.self)?.where({ $0.id.like(id) }).first else { return }
        delete(entity: model) { result in
            switch result {
            case .success:
                completed(nil)
            case .failure(let failure):
                completed(failure)
            }
        }
    }
}
