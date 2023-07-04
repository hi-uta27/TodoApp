//
//  ReadTaskUseCase.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Func readTask with: Date, TaskFilter? -> [TaskEnity]?
protocol ReadTaskUseCase {
    func readTask(filter: TaskFilter, completed: @escaping (Result<[TaskEntity]?, Error>) -> Void)
}
