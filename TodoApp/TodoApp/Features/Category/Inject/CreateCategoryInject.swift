//
//  CreateCategoryInject.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import Swinject

protocol CreateCategoryInject {}

extension CreateCategoryInject {
    static func registerCreateCategory(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
    }

    private static func registerData(container: Container) {
        container.register(CreateCategoryLocalDataSource.self) { _ in
            CategoriesLocalDataSourceImpl()
        }
        container.register(CreateCategoryRepository.self) { r in
            CreateCategoryRepositoryImpl(localDataSource: r.resolve(CreateCategoryLocalDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(CreateCategoryUseCase.self) { r in
            CreateCategoryUseCaseImpl(repository: r.resolve(CreateCategoryRepository.self)!)
        }
    }
}
