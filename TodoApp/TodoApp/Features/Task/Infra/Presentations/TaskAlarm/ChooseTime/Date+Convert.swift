//
//  Date+Convert.swift
//  TodoApp
//
//  Created by Heligate on 21/06/2023.
//

import Foundation

extension Date {
    var isAM: Bool {
        return hour > 12
    }

    func toAM() -> Date {
        guard isAM else {
            return self
        }
        let newTimeInterval = timeIntervalSince1970 - 12 * 3600
        return Date(timeIntervalSince1970: newTimeInterval)
    }

    func toPM() -> Date {
        guard !isAM else {
            return self
        }
        let newTimeInterval = timeIntervalSince1970 + 12 * 3600
        return Date(timeIntervalSince1970: newTimeInterval)
    }
}
