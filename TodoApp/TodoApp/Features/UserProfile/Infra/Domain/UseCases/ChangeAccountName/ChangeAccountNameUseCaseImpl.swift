//
//  ChangeAccountNameUseCaseImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation

class ChangeAccountNameUseCaseImpl: ChangeAccountNameUseCase {
    private var repository: ChangeAccountNameRepository

    init(repository: ChangeAccountNameRepository) {
        self.repository = repository
    }

    func changeAccountName(_ name: String, completed: @escaping (Result<String, Error>) -> Void) {
        repository.changeAccountName(name, completed: completed)
    }
}
