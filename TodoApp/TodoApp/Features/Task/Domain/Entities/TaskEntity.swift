//
//  TaskEntity.swift
//  TodoApp
//
//  Created by Heligate on 14/06/2023.
//

import Foundation

protocol TaskEntity {
    var id: String { get }
    var title: String { get }
    var descriptions: String? { get }
    var startTime: Date { get }
    var category: CategoryEntity { get }
    var priority: Int { get }
    var status: TaskStatus { get }
}
