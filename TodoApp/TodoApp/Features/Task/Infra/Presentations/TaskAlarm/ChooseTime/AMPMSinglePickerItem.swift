//
//  AMPMSinglePickerItem.swift
//  TodoApp
//
//  Created by Heligate on 21/06/2023.
//

import Foundation

class AMPMSinglePickerItem: SinglePickerItem {
    static func == (lhs: AMPMSinglePickerItem, rhs: AMPMSinglePickerItem) -> Bool {
        lhs.value == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }

    var title: String {
        return value.rawValue
    }

    var value: KindOfTime

    init(_ value: KindOfTime) {
        self.value = value
    }
}
