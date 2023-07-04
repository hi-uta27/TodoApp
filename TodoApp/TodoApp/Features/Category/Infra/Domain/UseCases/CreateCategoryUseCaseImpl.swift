//
//  CreateCategoryUseCaseImpl.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import Foundation

class CreateCategoryUseCaseImpl: CreateCategoryUseCase {
    private let repository: CreateCategoryRepository

    init(repository: CreateCategoryRepository) {
        self.repository = repository
    }

    func createCategory(name: String, icon: String, color: String, completed: @escaping (Error?) -> Void) {
        repository.createCategory(name: name, icon: icon, color: color, completed: completed)
    }
}
