//
//  ReadCategoryRepositoryImpl.swift
//  TodoApp
//
//  Created by Heligate on 07/06/2023.
//

import Foundation
import QRealmManagerPackage

class ReadCategoryRepositoryImpl: ReadCategoryRepository {
    private let localDataSource: ReadCategoryLocalDataSource

    init(localDataSource: ReadCategoryLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func readCategory(completed: @escaping (Result<[CategoryEntity], Error>) -> Void) {
        let defaultEntites = AppCategoryModel.defaultCategories
        localDataSource.readCategory { result in
            switch result {
            case .success(let localEntities):
                let entities: [CategoryEntity] = defaultEntites + localEntities
                completed(.success(entities))
            case .failure(let failure):
                if let failure = failure as? RealmErrorType, failure == RealmErrorType.realmIsEmpty {
                    completed(.success(defaultEntites))
                } else {
                    completed(.failure(failure))
                }
            }
        }
    }
}
