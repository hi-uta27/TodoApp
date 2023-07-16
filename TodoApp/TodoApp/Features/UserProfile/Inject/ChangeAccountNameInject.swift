//
//  ChangeAccountNameInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation
import Swinject

protocol ChangeAccountNameInject {}

extension ChangeAccountNameInject {
    static func registerChangeAccount(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(ChangeAccountNameRemoteDataSource.self) { _ in
            FirebaseUserProfile()
        }
        container.register(ChangeAccountNameRepository.self) { r in
            ChangeAccountNameRepositoryImpl(dataSource: r.resolve(ChangeAccountNameRemoteDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(ChangeAccountNameUseCase.self) { r in
            ChangeAccountNameUseCaseImpl(repository: r.resolve(ChangeAccountNameRepository.self)!)
        }
    }
}

extension FirebaseUserProfile: ChangeAccountNameRemoteDataSource {}
