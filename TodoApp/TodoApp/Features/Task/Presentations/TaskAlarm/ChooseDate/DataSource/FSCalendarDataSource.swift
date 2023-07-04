//
//  FSCalendarDataSource.swift
//  TodoApp
//
//  Created by Heligate on 20/06/2023.
//

import Foundation
import FSCalendar
import SwiftDate

class FSCalendarViewDataSource: NSObject {
    var didSelect: ((Date) -> Void)!

    func configCalendar(_ calendar: FSCalendar) {
        calendar.appearance.borderRadius = 0.6
        calendar.appearance.caseOptions = .weekdayUsesUpperCase
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 10, weight: .bold)
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor(named: "FF4949")
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(named: "FF4949")

        calendar.dataSource = self
        calendar.delegate = self
    }
}

// MARK: - FSCalendarDataSource

extension FSCalendarViewDataSource: FSCalendarDataSource {}

// MARK: - FSCalendarDelegate

extension FSCalendarViewDataSource: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        guard let today = Date().dateBySet([.hour: 0, .minute: 0, .second: 0, .nanosecond: 0]) else { return true }
        return date >= today
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(Self.self, #function)
        didSelect?(date)
    }
}

// MARK: - FSCalendarDelegateAppearance

extension FSCalendarViewDataSource: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        if date.compare(.isSameMonth(calendar.currentPage)) {
            // Background for day in month
            return UIColor(named: "272727")
        } else {
            return .clear
        }
    }
}
