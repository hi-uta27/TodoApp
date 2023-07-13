//
//  .swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation
import Swinject

protocol LoginInject {}

extension LoginInject {
    static func registerLogin(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(LoginRemoteDataSource.self) { _ in
            FirebaseAuthentications()
        }
        container.register(LoginRepository.self) { r in
            LoginRepositoryImpl(dataSource: r.resolve(LoginRemoteDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(LoginUseCase.self) { r in
            LoginUseCaseImpl(repository: r.resolve(LoginRepository.self)!)
        }
    }
}

extension FirebaseAuthentications: LoginRemoteDataSource {}
