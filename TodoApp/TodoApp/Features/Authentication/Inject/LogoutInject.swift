//
//  LogoutInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation
import Swinject

protocol LogoutInject {}

extension LogoutInject {
    static func registerLogout(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(LogoutRemoteDataSource.self) { _ in
            FirebaseAuthentications()
        }
        container.register(LogoutRepository.self) { r in
            LogoutRepositoryImpl(dataSource: r.resolve(LogoutRemoteDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(LogoutUseCase.self) { r in
            LogoutUseCaseImpl(repository: r.resolve(LogoutRepository.self)!)
        }
    }
}

extension FirebaseAuthentications: LogoutRemoteDataSource {}
