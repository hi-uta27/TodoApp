//
//  ReadTaskRepository.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Func readTask with: Date, TaskFilter? -> [TaskEnity]?

protocol ReadTaskRepository {
    func readTask(date: Date, keyword: String?, completed: @escaping (Result<[TaskEntity]?, Error>) -> Void)
}
