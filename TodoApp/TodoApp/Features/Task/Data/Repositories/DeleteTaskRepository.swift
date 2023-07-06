//
//  DeleteTaskRepository.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import Foundation

protocol DeleteTaskRepository {
    func deleteTask(id: String, completed: @escaping (Error?) -> Void)
}
