//
//  CreateCategoryLocalDataSource.swift
//  TodoApp
//
//  Created by Heligate on 12/06/2023.
//

import Foundation

protocol CreateCategoryLocalDataSource {
    func createCategory(_ category: RCategoryModel, completed: @escaping (Error?) -> Void)
}
