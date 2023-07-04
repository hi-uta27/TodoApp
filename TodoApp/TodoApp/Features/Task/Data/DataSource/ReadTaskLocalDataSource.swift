//
//  ReadTaskLocalDataSource.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// Func readTask with: Date, keyword? -> [RTaskModel]?

protocol ReadTaskLocalDataSource {
    func readTask(date: Date, keyword: String?, completed: @escaping (Result<[RTaskModel]?, Error>) -> Void)
}
