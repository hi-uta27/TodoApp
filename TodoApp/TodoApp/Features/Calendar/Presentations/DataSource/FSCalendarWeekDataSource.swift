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
    private var viewController: UIViewController!
    private var heighConstraint: NSLayoutConstraint!

    var didSelect: ((Date) -> Void)!

    func configCalendar(_ calendar: FSCalendar, heighConstraint: NSLayoutConstraint, from viewController: UIViewController) {
        calendar.scope = .week
        calendar.appearance.borderRadius = 0.6
        calendar.appearance.caseOptions = .weekdayUsesUpperCase
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 12, weight: .bold)
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 10, weight: .bold)
        calendar.weekdayHeight = 12
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor(named: "FF4949")
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor(named: "FF4949")

        calendar.dataSource = self
        calendar.delegate = self
        self.heighConstraint = heighConstraint
        self.viewController = viewController
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

    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        heighConstraint.constant = bounds.height
        viewController.view.layoutIfNeeded()
    }
}

// MARK: - FSCalendarDelegateAppearance

extension FSCalendarWeekDataSource: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return UIColor(named: "272727")
    }
}
