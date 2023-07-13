//
//  RegisterUseCaseImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

class RegisterUseCaseImpl: RegisterUseCase {
    private var repository: RegisterRepository

    init(repository: RegisterRepository) {
        self.repository = repository
    }

    func registerWith(email: String, password: String, confirmPassword: String, completed: @escaping (Result<UserEntity, Error>) -> Void) {
        repository.registerWith(email: email, password: password, confirmPassword: confirmPassword, completed: completed)
    }
}
