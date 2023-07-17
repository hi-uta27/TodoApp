//
//  ChangeAccountImageInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/17/23.
//

import Foundation
import Swinject

protocol ChangeAccountImageInject {}

extension ChangeAccountImageInject {
    static func registerChangeImage(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(ChangeAccountImageRemoteDataSource.self) { _ in
            FirebaseUserProfile()
        }
        container.register(ChangeAccountImageRepository.self) { r in
            ChangeAccountImageRepositoryImpl(dataSource: r.resolve(ChangeAccountImageRemoteDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(ChangeAccountImageUseCase.self) { r in
            ChangeAccountImageUseCaseImpl(repository: r.resolve(ChangeAccountImageRepository.self)!)
        }
    }
}

extension FirebaseUserProfile: ChangeAccountImageRemoteDataSource {}
