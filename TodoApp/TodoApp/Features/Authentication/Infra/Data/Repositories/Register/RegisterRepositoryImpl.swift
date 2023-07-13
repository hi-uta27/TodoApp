//
//  RegisterRepositoryImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

class RegisterRepositoryImpl: RegisterRepository {
    private var dataSource: RegisterRemoteDataSource

    init(dataSource: RegisterRemoteDataSource) {
        self.dataSource = dataSource
    }

    func registerWith(email: String, password: String, confirmPassword: String, completed: @escaping (Result<UserEntity, Error>) -> Void) {
        dataSource.registerWith(email: email, password: password, confirmPassword: confirmPassword) { result in
            switch result {
            case .success(let dto):
                completed(.success(dto.transferToModel()))
            case .failure(let failure):
                completed(.failure(failure))
            }
        }
    }
}
