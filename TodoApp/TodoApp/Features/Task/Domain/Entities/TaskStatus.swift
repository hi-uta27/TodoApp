//
//  TaskStatus.swift
//  TodoApp
//
//  Created by Heligate on 14/06/2023.
//

import Foundation
import RealmSwift

enum TaskStatus: Int, PersistableEnum, CaseIterable {
    case todo
    case completed
}
