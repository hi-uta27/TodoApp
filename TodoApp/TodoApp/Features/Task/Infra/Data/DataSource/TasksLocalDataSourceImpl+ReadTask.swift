//
//  TasksLocalDataSourceImpl+ReadTask.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation
import RealmSwift
import SwiftDate

extension TasksLocalDataSourceImpl {
    func readTask(date: Date?, keyword: String?, completed: @escaping (Result<[RTaskModel]?, Error>) -> Void) {
        if let results = queryAll(returningClass: RTaskModel.self) {
            if let date = date {
                filterResult(results, by: date, keyword: keyword, completed: completed)
            } else {
                completed(.success(Array(results)))
            }
        } else {
            completed(.success(nil))
        }
    }

    private func filterResult(_ results: Results<RTaskModel>, by date: Date, keyword: String?, completed: @escaping (Result<[RTaskModel]?, Error>) -> Void) {
        let resultsByDate = results.filter { $0.startTime.compare(.isSameDay(date)) }
        if let keyword = keyword, !keyword.isEmpty {
            let resultsByKeyword = resultsByDate.filter { $0.title.contains(keyword) }
            completed(.success(Array(resultsByKeyword)))
        } else {
            completed(.success(Array(resultsByDate)))
        }
    }
}
