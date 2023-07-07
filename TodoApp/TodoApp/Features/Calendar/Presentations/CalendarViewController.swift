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

    lazy var readTaskUseCase = di.resolve(ReadTaskUseCase.self)!
    private lazy var calendarDataSource = FSCalendarWeekDataSource()
    private var today: Date { Date() }

    override func configSubView() {
        super.configSubView()
        calendarDataSource.configCalendar(fsCalendar)
        calendarDataSource.didSelect = { [weak self] date in
            self?.readTask(with: date)
        }
        fsCalendar.select(today)
        updateCalendarLabel()

        readTask(with: today)
    }

    private func updateCalendarLabel() {
        monthLabel.text = fsCalendar.currentPage.monthName(.default)
        yearLabel.text = "\(fsCalendar.currentPage.year)"
    }

    private func readTask(with date: Date) {
        let filter = TaskFilterModel(date: date, keyword: nil)
        refreshTask(filter: filter, refreshTaskSuccess: { [weak self] taskEntities in
            print(self ?? "", #function, taskEntities ?? "")
        })
    }

    @IBAction private func touchUpInsidePreviousMonthButton(_ sender: Any) {
        let prevWeek = fsCalendar.currentPage.dateAt(.prevWeek)
        changeCalendar(with: prevWeek)
    }

    @IBAction private func touchUpInsideNextMonthButton(_ sender: Any) {
        let nextWeek = fsCalendar.currentPage.dateAt(.nextWeek)
        changeCalendar(with: nextWeek)
    }

    private func changeCalendar(with date: Date) {
        fsCalendar.setCurrentPage(date, animated: true)
        updateCalendarLabel()
    }
}

extension CalendarViewController: ReadTaskViewController {}
