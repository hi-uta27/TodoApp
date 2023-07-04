//
//  CategoryInject.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import Swinject

enum CategoryInject {
    static func register(container: Container) {
        registerReadCategory(container: container)
        registerCreateCategory(container: container)
    }
}

extension CategoryInject: ReadCategoryInject {}
extension CategoryInject: CreateCategoryInject {}
