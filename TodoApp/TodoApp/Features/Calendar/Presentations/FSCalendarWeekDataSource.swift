//
//  FSCalendarWeekDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/7/23.
//

import Foundation
import FSCalendar
import SwiftDate

class FSCalendarWeekDataSource: NSObject {
    var didSelect: ((Date) -> Void)!

    func configCalendar(_ calendar: FSCalendar) {
        calendar.appearance.borderRadius = 0.6
        calendar.appearance.caseOptions = .weekdayUsesUpperCase
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 10, weight: .bold)
        calendar.weekdayHeight = 12
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor(named: "FF4949")
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(named: "FF4949")

        calendar.dataSource = self
        calendar.delegate = self
    }
}

// MARK: - FSCalendarDataSource

extension FSCalendarWeekDataSource: FSCalendarDataSource {}

// MARK: - FSCalendarDelegate

extension FSCalendarWeekDataSource: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(Self.self, #function)
        didSelect?(date)
    }
}

// MARK: - FSCalendarDelegateAppearance

extension FSCalendarWeekDataSource: FSCalendarDelegateAppearance {}
