//
//  ReadCategoriesUseCase.swift
//  TodoApp
//
//  Created by Heligate on 07/06/2023.
//

import Foundation

protocol ReadCategoryUseCase {
    func readCategory(complete: @escaping (Result<[CategoryEntity], Error>) -> Void)
}
