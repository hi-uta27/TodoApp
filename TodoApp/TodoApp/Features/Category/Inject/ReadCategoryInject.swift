//
//  ReadCategoryInject.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import Swinject

protocol ReadCategoryInject {}

extension ReadCategoryInject {
    static func registerReadCategory(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(ReadCategoryLocalDataSource.self) { _ in
            CategoriesLocalDataSourceImpl()
        }
        container.register(ReadCategoryRepository.self) { r in
            ReadCategoryRepositoryImpl(localDataSource: r.resolve(ReadCategoryLocalDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(ReadCategoryUseCase.self) { r in
            ReadCategoryUseCaseImpl(repository: r.resolve(ReadCategoryRepository.self)!)
        }
    }
}
