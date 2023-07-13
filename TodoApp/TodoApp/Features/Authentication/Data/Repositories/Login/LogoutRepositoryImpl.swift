//
//  LogoutRepositoryImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

class LogoutRepositoryImpl: LogoutRepository {
    private var dataSource: LogoutRemoteDataSource

    init(dataSource: LogoutRemoteDataSource) {
        self.dataSource = dataSource
    }

    func logout(completed: @escaping (Error?) -> Void) {
        dataSource.logout(completed: completed)
    }
}
