//
//  ReadCategoryLocalDataSource.swift
//  TodoApp
//
//  Created by Heligate on 12/06/2023.
//

import Foundation

protocol ReadCategoryLocalDataSource {
    func readCategory(completed: @escaping (Result<[RCategoryModel], Error>) -> Void)
}
