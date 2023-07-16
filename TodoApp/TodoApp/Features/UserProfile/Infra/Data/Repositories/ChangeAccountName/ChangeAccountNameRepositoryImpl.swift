//
//  ChangeAccountNameRepositoryImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation

class ChangeAccountNameRepositoryImpl: ChangeAccountNameRepository {
    private var dataSource: ChangeAccountNameRemoteDataSource

    init(dataSource: ChangeAccountNameRemoteDataSource) {
        self.dataSource = dataSource
    }

    func changeAccountName(_ name: String, completed: @escaping (Result<String, Error>) -> Void) {
        dataSource.changeAccountName(name, completed: completed)
    }
}
