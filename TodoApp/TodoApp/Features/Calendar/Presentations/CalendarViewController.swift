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
    lazy var updateTaskUseCase = di.resolve(UpdateTaskUseCase.self)!
    private lazy var calendarDataSource = FSCalendarWeekDataSource()
    private lazy var tableViewDataSource = CalendarTableViewDataSource()
    private var router: TaskScreenRouter!
    private var taskEntities: [TaskEntity] = []
    private var selectedDate: Date = .init()
    private var selectedStatus: TaskStatus = .todo

    override func viewDidLoad() {
        super.viewDidLoad()
        registerObserveTaskNotification()
    }

    override func configSubView() {
        super.configSubView()
        calendarDataSource.configCalendar(fsCalendar)
        calendarDataSource.didSelect = { [weak self] date in
            self?.selectedDate = date
            self?.readTask(with: date)
        }
        fsCalendar.select(selectedDate)
        updateCalendarLabel()

        tableViewDataSource.configTableView(tableView)
        tableViewDataSource.didSelectItem = { [weak self] taskEntity in
            self?.didSelectItem(taskEntity: taskEntity)
        }
        tableViewDataSource.tapInsideCheckBox = { [weak self] taskEntity in
            self?.toogleTaskStatus(taskEntity)
        }
        tableViewDataSource.tapInsideTodoButton = { [weak self] in
            self?.selectedStatus = .todo
            self?.setModels()
        }
        tableViewDataSource.tapInsideCompletedButton = { [weak self] in
            self?.selectedStatus = .completed
            self?.setModels()
        }

        readTask(with: selectedDate)
    }

    private func updateCalendarLabel() {
        monthLabel.text = fsCalendar.currentPage.monthName(.default)
        yearLabel.text = "\(fsCalendar.currentPage.year)"
    }

    private func didSelectItem(taskEntity: TaskEntity) {
        router = di.resolve(TaskScreenRouter.self)!
        router.openDetailTask(from: self, taskEntity: taskEntity) { taskEntity in
            print(Self.self, #function, taskEntity)
        }
    }

    private func readTask(with date: Date) {
        let filter = TaskFilterModel(date: date, keyword: nil)
        refreshTask(filter: filter, refreshTaskSuccess: { [weak self] taskEntities in
            self?.taskEntities = taskEntities ?? []
            self?.setModels()
        })
    }

    private func setModels() {
        tableViewDataSource.setModels(taskEntities.filter { $0.status == selectedStatus })
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

    // MARK: observeTaskChangeNotification

    private func registerObserveTaskNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(observeTaskChangeNotification), name: .taskChangeNotification, object: nil)
    }

    @objc private func observeTaskChangeNotification() {
        readTask(with: selectedDate)
    }

    private func removeObserveTaskNotification() {
        NotificationCenter.default.removeObserver(self, name: .taskChangeNotification, object: nil)
    }

    deinit {
        removeObserveTaskNotification()
    }
}

extension CalendarViewController: ReadTaskViewController {}
extension CalendarViewController: UpdateTaskViewController {}
