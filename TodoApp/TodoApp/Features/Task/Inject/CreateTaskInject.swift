//
//  CreateTaskInject.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import Foundation
import Swinject

protocol CreateTaskInject {}

extension CreateTaskInject {
    static func registerCreateTask(container: Container) {
        registerData(container: container)
        registerUseCase(container: container)
        registerPresentation(container: container)
    }

    private static func registerPresentation(container: Container) {
        container.register(TaskScreenRouter.self) { _ in
            TaskScreenRouterImpl()
        }
    }

    private static func registerData(container: Container) {
        container.register(CreateTaskLocalDataSource.self) { r in
            r.resolve(TasksLocalDataSource.self)!
        }
        container.register(CreateTaskRepository.self) { r in
            CreateTaskRepositoryImpl(localDataSource: r.resolve(CreateTaskLocalDataSource.self)!)
        }
    }

    private static func registerUseCase(container: Container) {
        container.register(CreateTaskUseCase.self) { r in
            CreateTaskUseCaseImpl(repository: r.resolve(CreateTaskRepository.self)!)
        }
    }
}
