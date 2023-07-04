//
//  DateModel.swift
//  TodoApp
//
//  Created by Heligate on 22/06/2023.
//

import Foundation
import SwiftDate

class DateModel {
    var day: Int?
    var month: Int?
    var year: Int?
    var hour: Int?
    var minute: Int?

    init(day: Int? = nil, month: Int? = nil, year: Int? = nil, hour: Int? = nil, minute: Int? = nil) {
        self.day = day
        self.month = month
        self.year = year
        self.hour = hour
        self.minute = minute
    }

    init(date: Date) {
        day = date.day
        month = date.month
        year = date.year
        hour = date.hour
        minute = date.minute
    }
}

extension DateModel {
    func setDate(day: Int?, month: Int?, year: Int?) {
        self.day = day
        self.month = month
        self.year = year
    }

    func setTime(hour: Int?, minute: Int?) {
        self.hour = hour
        self.minute = minute
    }

    func toDate() -> Date? {
        if let day = day,
           let month = month,
           let year = year,
           let hour = hour,
           let minute = minute,
           let date = Date().dateBySet([.day: day, .month: month, .year: year, .hour: hour, .minute: minute])
        {
            return date
        } else {
            return nil
        }
    }
}
