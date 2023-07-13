//
//  LogoutUseCaseImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

class LogoutUseCaseImpl: LogoutUseCase {
    private var repository: LogoutRepository

    init(repository: LogoutRepository) {
        self.repository = repository
    }

    func logout(completed: @escaping (Error?) -> Void) {
        repository.logout(completed: completed)
    }
}
