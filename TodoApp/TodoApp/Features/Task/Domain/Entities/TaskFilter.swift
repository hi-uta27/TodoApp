//
//  TaskFilter.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import Foundation

// TaskFilter with: keyword
protocol TaskFilter {
    var date: Date { get }
    var keyword: String? { get }
}
