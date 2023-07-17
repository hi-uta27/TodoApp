//
//  ChangeAccountImageRepositoryImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/17/23.
//

import Foundation

class ChangeAccountImageRepositoryImpl: ChangeAccountImageRepository {
    private var dataSource: ChangeAccountImageRemoteDataSource

    init(dataSource: ChangeAccountImageRemoteDataSource) {
        self.dataSource = dataSource
    }

    func changeImage(_ image: Data, compledted completed: @escaping (Result<URL, Error>) -> Void) {
        dataSource.changeImage(image, completed: completed)
    }
}
