//
//  TasksLocalDataSourceImpl+ReadTask.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation
import SwiftDate

extension TasksLocalDataSourceImpl {
    func readTask(date: Date, keyword: String?, completed: @escaping (Result<[RTaskModel]?, Error>) -> Void) {
        if let results = queryAll(returningClass: RTaskModel.self)?.filter({ $0.startTime.compare(.isSameDay(date)) }) {
            if let keyword = keyword, !keyword.isEmpty {
                let resultsByKeyword = results.filter { $0.title.contains(keyword) }
                completed(.success(Array(resultsByKeyword)))
            } else {
                completed(.success(Array(results)))
            }
        } else {
            completed(.success(nil))
        }
    }
}
