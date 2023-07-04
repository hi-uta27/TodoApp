//
//  RTaskModel.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import Foundation
import RealmSwift

class RTaskModel: Object, TaskEntity {
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var descriptions: String?
    @Persisted var startTime: Date
    @Persisted var priority: Int
    @Persisted var status: TaskStatus = .todo

    @Persisted var rCategory: RCategoryEmbbedModel!

    var category: CategoryEntity {
        rCategory
    }

    convenience init(id: String,
                     title: String,
                     descriptions: String? = nil,
                     startTime: Date,
                     priority: Int,
                     status: TaskStatus,
                     category: CategoryEntity)
    {
        self.init()
        self.id = id
        self.title = title
        self.descriptions = descriptions
        self.startTime = startTime
        self.priority = priority
        self.status = status
        self.rCategory = RCategoryEmbbedModel(entity: category)
    }

    convenience init(title: String,
                     descriptions: String? = nil,
                     startTime: Date,
                     priority: Int,
                     category: CategoryEntity)
    {
        self.init()
        self.id = ObjectId.generate().stringValue
        self.title = title
        self.descriptions = descriptions
        self.startTime = startTime
        self.priority = priority
        self.rCategory = RCategoryEmbbedModel(entity: category)
    }

    convenience init(entity: TaskEntity) {
        self.init()
        self.id = entity.id
        self.title = entity.title
        self.descriptions = entity.descriptions
        self.startTime = entity.startTime
        self.priority = entity.priority
        self.rCategory = RCategoryEmbbedModel(entity: entity.category)
    }
}

class RCategoryEmbbedModel: EmbeddedObject, CategoryEntity {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var icon: String
    @Persisted var color: String

    convenience init(entity: CategoryEntity) {
        self.init()
        self.id = entity.id
        self.name = entity.name
        self.icon = entity.icon
        self.color = entity.color
    }
}
