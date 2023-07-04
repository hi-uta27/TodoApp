//
//  CategoriesLocalDataSourceImpl.swift
//  TodoApp
//
//  Created by Heligate on 07/06/2023.
//

import QRealmManagerPackage
import RealmSwift

class CategoriesLocalDataSourceImpl: DatabaseConfigurable {
    var realmMemoryType: RealmMemoryType {
        .inStorage
    }

    var schemaName: String? {
        "Category"
    }

    var schemaVersion: UInt64? {
        0
    }

    var objectTypes: [Object.Type]? {
        [RCategoryModel.self]
    }

    var embeddedObjectTypes: [EmbeddedObject.Type]? {
        nil
    }

    var migrationBlock: MigrationBlock? {
        nil
    }
}

extension CategoriesLocalDataSourceImpl: ReadCategoryLocalDataSource {
    func readCategory(completed: @escaping (Result<[RCategoryModel], Error>) -> Void) {
        if let results = queryAll(returningClass: RCategoryModel.self) {
            completed(.success(Array(results)))
        } else {
            completed(.failure(RealmErrorType.realmIsEmpty))
        }
    }
}

extension CategoriesLocalDataSourceImpl: CreateCategoryLocalDataSource {
    func createCategory(_ category: RCategoryModel, completed: @escaping (Error?) -> Void) {
        save(entity: category, update: false) { result in
            switch result {
            case .success:
                completed(nil)
            case .failure(let failure):
                completed(failure)
            }
        }
    }
}
