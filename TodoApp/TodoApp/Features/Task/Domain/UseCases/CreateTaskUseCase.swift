//
//  CreateTaskUseCase.swift
//  TodoApp
//
//  Created by Heligate on 14/06/2023.
//

import Foundation

protocol CreateTaskUseCase {
    func createTask(title: String, description: String?, startTime: Date, category: CategoryEntity, priority: Int, completed: @escaping (Result<TaskEntity, Error>) -> Void)
}
