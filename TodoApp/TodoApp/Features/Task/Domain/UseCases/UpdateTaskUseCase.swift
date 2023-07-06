//
//  UpdateTaskUseCase.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

protocol UpdateTaskUseCase {
    func toogleTaskStatus(_ taskEntity: TaskEntity, complete: @escaping (Error?) -> Void)
    func update(_ taskEntity: TaskEntity, title: String, description: String?, dateTime: Date,
                category: CategoryEntity, priority: Int, status: TaskStatus, complete: @escaping (Error?) -> Void)
}
