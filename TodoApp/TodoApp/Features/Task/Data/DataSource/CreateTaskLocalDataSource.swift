//
//  CreateTaskLocalDataSource.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import Foundation

protocol CreateTaskLocalDataSource {
    func createTask(_ task: RTaskModel, completed: @escaping (Result<RTaskModel, Error>) -> Void)
}
