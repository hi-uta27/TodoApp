//
//  RegisterInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation
import Swinject

protocol RegisterInject {}

extension RegisterInject {
    static func registerRegisterAccount(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(RegisterRemoteDataSource.self) { _ in
            FirebaseAuthentications()
        }
        container.register(RegisterRepository.self) { r in
            RegisterRepositoryImpl(dataSource: r.resolve(RegisterRemoteDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(RegisterUseCase.self) { r in
            RegisterUseCaseImpl(repository: r.resolve(RegisterRepository.self)!)
        }
    }
}

extension FirebaseAuthentications: RegisterRemoteDataSource {}
