//
//  CalendarViewController.swift
//  TodoApp
//
//  Created by Heligate on 30/06/2023.
//

import FSCalendar
import UIKit

class CalendarViewController: BaseViewController {
    @IBOutlet private var fsCalendar: FSCalendar!
    @IBOutlet private var monthLabel: UILabel!
    @IBOutlet private var yearLabel: UILabel!
    @IBOutlet private var tableView: UITableView!

    private lazy var calendarDataSource = FSCalendarWeekDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configSubView() {
        super.configSubView()
        fsCalendar.scope = .week
        calendarDataSource.configCalendar(fsCalendar)
        calendarDataSource.didSelect = { [weak self] date in
            print(self ?? "", date)
        }
        fsCalendar.select(Date())
        updateCalendarLabel()
    }

    private func updateCalendarLabel() {
        monthLabel.text = fsCalendar.currentPage.monthName(.default)
        yearLabel.text = "\(fsCalendar.currentPage.year)"
    }

    @IBAction private func touchUpInsidePreviousMonthButton(_ sender: Any) {
        let prevMonth = fsCalendar.currentPage.dateAt(.prevWeek)
        changeCalendar(with: prevMonth)
    }

    @IBAction private func touchUpInsideNextMonthButton(_ sender: Any) {
        let nextMonth = fsCalendar.currentPage.dateAt(.nextWeek)
        changeCalendar(with: nextMonth)
    }

    private func changeCalendar(with date: Date) {
        fsCalendar.setCurrentPage(date, animated: true)
        updateCalendarLabel()
    }
}
