//
//  TimeSinglePickerItem.swift
//  TodoApp
//
//  Created by Heligate on 21/06/2023.
//

import Foundation

class TimeSinglePickerItem: SinglePickerItem {
    static func == (lhs: TimeSinglePickerItem, rhs: TimeSinglePickerItem) -> Bool {
        lhs.value == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }

    var title: String {
        return value < 10 ? "0\(value)" : "\(value)"
    }

    var value: Int

    init(_ value: Int) {
        self.value = value
    }
}

extension TimeSinglePickerItem {
    static let hours = (1 ... 12).map { TimeSinglePickerItem($0) }
    static let minutes = (0 ... 59).map { TimeSinglePickerItem($0) }
}
