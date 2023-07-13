//
//  LoginUseCaseImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

class LoginUseCaseImpl: LoginUseCase {
    private var repository: LoginRepository

    init(repository: LoginRepository) {
        self.repository = repository
    }

    func loginWith(email: String, password: String, completed: @escaping (Result<UserEntity, Error>) -> Void) {
        repository.loginWith(email: email, password: password, completed: completed)
    }

    func loginWithGoogle(completed: @escaping (Result<UserEntity, Error>) -> Void) {
        repository.loginWithGoogle(completed: completed)
    }
}
