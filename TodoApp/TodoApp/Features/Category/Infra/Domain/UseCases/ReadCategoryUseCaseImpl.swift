//
//  ReadCategoryUseCaseImpl.swift
//  TodoApp
//
//  Created by Heligate on 07/06/2023.
//

import Foundation

class ReadCategoryUseCaseImpl: ReadCategoryUseCase {
    private let repository: ReadCategoryRepository

    init(repository: ReadCategoryRepository) {
        self.repository = repository
    }

    func readCategory(complete: @escaping (Result<[CategoryEntity], Error>) -> Void) {
        repository.readCategory(completed: complete)
    }
}
