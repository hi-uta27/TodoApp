//
//  ChangePasswordRepositoryImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation

class ChangePasswordRepositoryImpl: ChangePasswordRepositories {
    private var dataSource: ChangePasswordRemoteDataSource

    init(dataSource: ChangePasswordRemoteDataSource) {
        self.dataSource = dataSource
    }

    func changePassword(_ password: String, completed: @escaping (Error?) -> Void) {
        dataSource.changePassword(password, completed: completed)
    }
}
