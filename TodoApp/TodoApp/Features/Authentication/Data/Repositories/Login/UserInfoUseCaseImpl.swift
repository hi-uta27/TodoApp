//
//  UserInfoUseCaseImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

class UserInfoUseCaseImpl: UserInforUseCase {
    private var repository: UserInfoRepository

    init(repository: UserInfoRepository) {
        self.repository = repository
    }

    func readUserInfor(completed: @escaping (UserEntity?) -> Void) {
        repository.readUserInfor(completed: completed)
    }
}
