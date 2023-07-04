//
//  UpdateTaskUseCase.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Func updateTask with: TaskEntity -> Error?
protocol UpdateTaskUseCase {
    func toogleTaskStatus(_ taskEntity: TaskEntity, complete: @escaping (Error?) -> Void)
}
