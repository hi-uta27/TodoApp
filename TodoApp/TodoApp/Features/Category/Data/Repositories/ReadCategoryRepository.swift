//
//  ReadCategoryRepository.swift
//  TodoApp
//
//  Created by Heligate on 07/06/2023.
//

import Foundation

protocol ReadCategoryRepository {
    func readCategory(completed: @escaping (Result<[CategoryEntity], Error>) -> Void)
}
