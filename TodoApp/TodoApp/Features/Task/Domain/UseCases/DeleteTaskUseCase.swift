//
//  DeleteTaskUseCase.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import Foundation

protocol DeleteTaskUseCase {
    func deleteTask(_ taskEntity: TaskEntity, completed: @escaping (Error?) -> Void)
}
