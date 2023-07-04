//
//  ReadTaskInject.swift
//  TodoApp
//
//  Created by Heligate on 27/06/2023.
//

import Foundation
import Swinject

protocol ReadTaskInject {}

extension ReadTaskInject {
    static func registerReadTask(container: Container) {
        registerData(container: container)
        registerDomain(container: container)
    }

    private static func registerData(container: Container) {
        container.register(ReadTaskLocalDataSource.self) { r in
            r.resolve(TasksLocalDataSource.self)!
        }
        container.register(ReadTaskRepository.self) { r in
            ReadTaskRepositoryImpl(localDataSource: r.resolve(ReadTaskLocalDataSource.self)!)
        }
    }

    private static func registerDomain(container: Container) {
        container.register(ReadTaskUseCase.self) { r in
            ReadTaskUseCaseImpl(repository: r.resolve(ReadTaskRepository.self)!)
        }
    }
}
