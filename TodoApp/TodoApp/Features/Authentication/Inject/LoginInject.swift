//
//  .swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Swinject
import UIKit

protocol LoginInject {}

extension LoginInject {
    static func registerLogin(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(LoginRemoteDataSource.self) { _, viewController in
            FirebaseAuthentications(viewController: viewController)
        }
        container.register(LoginRepository.self) { r, viewController in
            LoginRepositoryImpl(dataSource: r.resolve(LoginRemoteDataSource.self, argument: viewController as UIViewController)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(LoginUseCase.self) { r, viewController in
            LoginUseCaseImpl(repository: r.resolve(LoginRepository.self, argument: viewController as UIViewController)!)
        }
    }
}

extension FirebaseAuthentications: LoginRemoteDataSource {}
