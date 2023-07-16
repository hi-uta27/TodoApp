//
//  ChangePasswordInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation
import Swinject

protocol ChangePasswordInject {}

extension ChangePasswordInject {
    static func registerChangePassword(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(ChangePasswordRemoteDataSource.self) { _ in
            FirebaseUserProfile()
        }
        container.register(ChangePasswordRepositories.self) { r in
            ChangePasswordRepositoryImpl(dataSource: r.resolve(ChangePasswordRemoteDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(ChangePasswordUseCase.self) { r in
            ChangePasswordUseCaseImpl(repository: r.resolve(ChangePasswordRepositories.self)!)
        }
    }
}

extension FirebaseUserProfile: ChangePasswordRemoteDataSource {}
