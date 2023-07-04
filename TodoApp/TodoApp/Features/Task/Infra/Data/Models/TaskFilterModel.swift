//
//  TaskFilterModel.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

struct TaskFilterModel: TaskFilter {
    let date: Date
    let keyword: String?
}
