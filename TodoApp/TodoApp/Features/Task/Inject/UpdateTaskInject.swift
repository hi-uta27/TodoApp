//
//  UpdateTaskInject.swift
//  TodoApp
//
//  Created by Heligate on 27/06/2023.
//

import Foundation
import Swinject

protocol UpdateTaskInject {}

extension UpdateTaskInject {
    static func registerUpdateTask(container: Container) {
        registerData(container: container)
        registerDomain(container: container)
    }

    private static func registerData(container: Container) {
        container.register(UpdateTaskLocalDataSource.self) { r in
            r.resolve(TasksLocalDataSource.self)!
        }
        container.register(UpdateTaskRepository.self) { r in
            UpdateTaskRepositoryImpl(localDataSource: r.resolve(UpdateTaskLocalDataSource.self)!)
        }
    }

    private static func registerDomain(container: Container) {
        container.register(UpdateTaskUseCase.self) { r in
            UpdateTaskUseCaseImpl(repository: r.resolve(UpdateTaskRepository.self)!)
        }
    }
}
