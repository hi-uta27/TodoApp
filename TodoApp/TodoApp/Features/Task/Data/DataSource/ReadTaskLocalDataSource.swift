//
//  ReadTaskLocalDataSource.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

protocol ReadTaskLocalDataSource {
    func readTask(date: Date?, keyword: String?, completed: @escaping (Result<[RTaskModel]?, Error>) -> Void)
}
