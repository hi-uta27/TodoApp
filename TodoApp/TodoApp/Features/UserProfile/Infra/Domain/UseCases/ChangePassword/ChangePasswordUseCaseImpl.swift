//
//  ChangePasswordUseCaseImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation

class ChangePasswordUseCaseImpl: ChangePasswordUseCase {
    private var repository: ChangePasswordRepositories

    init(repository: ChangePasswordRepositories) {
        self.repository = repository
    }

    func changePassword(_ password: String, oldPassword: String, completed: @escaping (Error?) -> Void) {
        repository.changePassword(password, oldPassword: oldPassword, completed: completed)
    }
}
