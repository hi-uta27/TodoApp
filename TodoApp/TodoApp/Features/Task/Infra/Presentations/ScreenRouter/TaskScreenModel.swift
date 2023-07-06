//
//  TaskScreenModel.swift
//  TodoApp
//
//  Created by Heligate on 22/06/2023.
//

import Foundation

class TaskScreenModel {
    var title: String?
    var description: String?
    var dateTime: DateModel = .init()
    var category: CategoryEntity?
    var priority: Int?
}
