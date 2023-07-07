//
//  TaskPresentation.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import Foundation

class TaskPresentation {
    let taskEntity: TaskEntity
    private(set) var title: String
    private(set) var description: String?
    private(set) var startTime: Date
    private(set) var category: CategoryEntity
    private(set) var priority: Int
    private(set) var status: TaskStatus

    init(taskEntity: TaskEntity) {
        self.taskEntity = taskEntity
        title = taskEntity.title
        description = taskEntity.descriptions
        startTime = taskEntity.startTime
        category = taskEntity.category
        priority = taskEntity.priority
        status = taskEntity.status
    }
}

extension TaskPresentation {
    func setTitle(_ title: String) {
        self.title = title
    }

    func setDescription(_ description: String?) {
        self.description = description
    }

    func setStartTime(_ startTime: Date) {
        self.startTime = startTime
    }

    func setCategory(_ category: CategoryEntity) {
        self.category = category
    }

    func setPriority(_ priority: Int) {
        self.priority = priority
    }

    func toggleStatus() {
        status = status.toggle()
    }

    func refresh() {
        title = taskEntity.title
        description = taskEntity.descriptions
        startTime = taskEntity.startTime
        category = taskEntity.category
        priority = taskEntity.priority
        status = taskEntity.status
    }
}
