//
//  CreateCategoryRepositoryImpl.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import Foundation
import RealmSwift

class CreateCategoryRepositoryImpl: CreateCategoryRepository {
    private let localDataSource: CreateCategoryLocalDataSource

    init(localDataSource: CreateCategoryLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func createCategory(name: String, icon: String, color: String, completed: @escaping (Error?) -> Void) {
        let category = RCategoryModel(value: [ObjectId.generate().stringValue, name, icon, color])
        localDataSource.createCategory(category, completed: completed)
    }
}
