//
//  ReadTaskRepositoryImpl.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Impl ReadTaskRepository

class ReadTaskRepositoryImpl: ReadTaskRepository {
    private let localDataSource: ReadTaskLocalDataSource

    init(localDataSource: ReadTaskLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func readTask(date: Date?, keyword: String?, completed: @escaping (Result<[TaskEntity]?, Error>) -> Void) {
        localDataSource.readTask(date: date, keyword: keyword) { result in
            switch result {
            case .success(let entities):
                completed(.success(entities))
            case .failure(let failure):
                completed(.failure(failure))
            }
        }
    }
}
