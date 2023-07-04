//
//  TaskInject.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import Foundation
import Swinject

extension NSNotification.Name {
    static let taskChangeNotification = Notification.Name("NSNotification_TaskChangeNotification")
}

enum TaskInject {
    static func register(container: Container) {
        registerTaskLocalDataSource(container: container)
        registerCreateTask(container: container)
        registerReadTask(container: container)
        registerUpdateTask(container: container)
    }
}

extension TaskInject {
    private static func registerTaskLocalDataSource(container: Container) {
        container.register(TasksLocalDataSource.self) { _ in
            let tasksLocalDataSourceImpl = TasksLocalDataSourceImpl()
            tasksLocalDataSourceImpl.startObserveRealmNotification { _, _ in
                NotificationCenter.default.post(name: .taskChangeNotification, object: nil)
            }
            return tasksLocalDataSourceImpl
        }.inObjectScope(.container)
    }
}

extension TaskInject: CreateTaskInject {}
extension TaskInject: ReadTaskInject {}
extension TaskInject: UpdateTaskInject {}
