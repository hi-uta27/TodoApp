//
//  CreateCategoryRepository.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import Foundation

protocol CreateCategoryRepository {
    func createCategory(name: String, icon: String, color: String, completed: @escaping (Error?) -> Void)
}
