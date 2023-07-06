//
//  DeleteTaskInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import Foundation
import Swinject

protocol DeleteTaskInject {}

extension DeleteTaskInject {
    static func registerDeleteTask(container: Container) {
        registerData(container: container)
        registerDomain(container: container)
    }

    private static func registerData(container: Container) {
        container.register(DeleteTaskLocalDataSource.self) { r in
            r.resolve(TasksLocalDataSource.self)!
        }
        container.register(DeleteTaskRepository.self) { r in
            DeleteTaskRepositoryImpl(localDataSource: r.resolve(DeleteTaskLocalDataSource.self)!)
        }
    }

    private static func registerDomain(container: Container) {
        container.register(DeleteTaskUseCase.self) { r in
            DeleteTaskUseCaseImpl(repository: r.resolve(DeleteTaskRepository.self)!)
        }
    }
}
