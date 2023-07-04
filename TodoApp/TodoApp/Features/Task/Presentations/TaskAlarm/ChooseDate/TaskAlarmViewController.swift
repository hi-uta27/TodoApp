//
//  TaskAlarmViewController.swift
//  TodoApp
//
//  Created by Heligate on 16/06/2023.
//

import FSCalendar
import UIKit

class TaskAlarmViewController: BaseViewController {
    @IBOutlet private var backgroundContentView: UIView!
    @IBOutlet private var cancelButton: UIButton!
    @IBOutlet private var chooseTimeButton: UIButton!
    @IBOutlet private var fsCalendar: FSCalendar!
    @IBOutlet private var monthLabel: UILabel!
    @IBOutlet private var yearLabel: UILabel!

    private lazy var calendarDataSource = FSCalendarViewDataSource()
    private var selectedDate: Date?
    private var didSelectDate: ((Int, Int, Int) -> Void)!
    private var openChooseTime: (() -> Void)!

    override func configSubView() {
        print(Self.self, #function)
        backgroundContentView.roundCorners(with: 4)
        chooseTimeButton.roundCorners(with: 4)
        calendarDataSource.configCalendar(fsCalendar)
        calendarDataSource.didSelect = { [weak self] date in
            self?.selectedDate = date
        }
        fsCalendar.select(selectedDate)
        updateCalendarLabel()
    }

    private func updateCalendarLabel() {
        monthLabel.text = fsCalendar.currentPage.monthName(.default)
        yearLabel.text = "\(fsCalendar.currentPage.year)"
    }

    @IBAction private func touchUpInsidePreviousMonthButton(_ sender: Any) {
        let prevMonth = fsCalendar.currentPage.dateAt(.prevMonth)
        changeCalendar(with: prevMonth)
    }

    @IBAction private func touchUpInsideNextMonthButton(_ sender: Any) {
        let nextMonth = fsCalendar.currentPage.dateAt(.nextMonth)
        changeCalendar(with: nextMonth)
    }

    private func changeCalendar(with date: Date) {
        fsCalendar.setCurrentPage(date, animated: true)
        updateCalendarLabel()
    }

    override func shoudClose() -> Bool {
        navigationController?.popSlideDown()
        return false
    }

    @IBAction private func touchUpInsideChooseTimeButton(_ sender: Any) {
        guard let date = selectedDate else { return }
        didSelectDate?(date.day, date.month, date.year)
        openChooseTime?()
    }
}

extension TaskAlarmViewController {
    static func initialize(day: Int?, month: Int?, year: Int?,
                           didSelectDate: @escaping (Int, Int, Int) -> Void,
                           openChooseTime: @escaping () -> Void) -> Self
    {
        let viewController = initial()
        let today = Date()
        if let day = day, let month = month, let year = year {
            viewController.selectedDate = today.dateBySet([.day: day, .month: month, .year: year])
        } else {
            viewController.selectedDate = today
        }
        viewController.didSelectDate = didSelectDate
        viewController.openChooseTime = openChooseTime
        return viewController
    }
}

extension UIViewController {
    func presentTaskAlarm(day: Int?, month: Int?, year: Int?,
                          didSelectDate: @escaping (Int, Int, Int) -> Void,
                          openChooseTime: @escaping () -> Void,
                          complete: (() -> Void)?)
    {
        let viewController = TaskAlarmViewController.initialize(day: day, month: month, year: year,
                                                                didSelectDate: didSelectDate,
                                                                openChooseTime: openChooseTime)
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
}
