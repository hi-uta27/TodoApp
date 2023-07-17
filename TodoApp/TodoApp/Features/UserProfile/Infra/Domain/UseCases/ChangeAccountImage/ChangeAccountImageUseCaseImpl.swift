//
//  ChangeAccountImageUseCaseImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/17/23.
//

import Foundation

class ChangeAccountImageUseCaseImpl: ChangeAccountImageUseCase {
    private var repository: ChangeAccountImageRepository

    init(repository: ChangeAccountImageRepository) {
        self.repository = repository
    }

    func changeImage(_ image: Data, completed: @escaping (Result<URL, Error>) -> Void) {
        repository.changeImage(image, compledted: completed)
    }
}
