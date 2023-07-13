//
//  LoginRepositoryImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

class LoginRepositoryImpl: LoginRepository {
    private var dataSource: LoginRemoteDataSource

    init(dataSource: LoginRemoteDataSource) {
        self.dataSource = dataSource
    }

    func loginWith(email: String, password: String, completed: @escaping (Result<UserEntity, Error>) -> Void) {
        dataSource.loginWith(email: email, password: password) { result in
            switch result {
            case .success(let dto):
                completed(.success(dto.transferToModel()))
            case .failure(let failure):
                completed(.failure(failure))
            }
        }
    }

    func loginWithGoogle(completed: @escaping (Result<UserEntity, Error>) -> Void) {
        dataSource.loginWithGoogle { result in
            switch result {
            case .success(let dto):
                completed(.success(dto.transferToModel()))
            case .failure(let failure):
                completed(.failure(failure))
            }
        }
    }
}
