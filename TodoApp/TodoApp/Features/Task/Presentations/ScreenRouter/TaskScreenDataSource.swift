//
//  TaskScreenDataSource.swift
//  TodoApp
//
//  Created by Heligate on 22/06/2023.
//

import Foundation

protocol TaskScreenDataSource: NSObject {
    func didUpdateDateTime(_ dateTime: Date)
    func didUpdateCategory(_ category: CategoryEntity)
    func didUpdatePriority(_ priority: Int)
}
