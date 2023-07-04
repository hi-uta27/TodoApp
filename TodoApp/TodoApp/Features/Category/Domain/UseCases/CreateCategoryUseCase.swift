//
//  CreateCategoryUseCase.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import Foundation

protocol CreateCategoryUseCase {
    func createCategory(name: String, icon: String, color: String, completed: @escaping (Error?) -> Void)
}
