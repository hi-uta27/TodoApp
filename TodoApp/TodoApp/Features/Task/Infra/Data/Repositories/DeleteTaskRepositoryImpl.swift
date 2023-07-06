//
//  DeleteTaskRepositoryImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import Foundation

class DeleteTaskRepositoryImpl: DeleteTaskRepository {
    private let localDataSource: DeleteTaskLocalDataSource

    init(localDataSource: DeleteTaskLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func deleteTask(id: String, completed: @escaping (Error?) -> Void) {
        localDataSource.deleteTask(id: id, completed: completed)
    }
}
