//
//  RCategoryModel.swift
//  TodoApp
//
//  Created by Heligate on 07/06/2023.
//

import RealmSwift

class RCategoryModel: Object, CategoryEntity {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var icon: String
    @Persisted var color: String
}
