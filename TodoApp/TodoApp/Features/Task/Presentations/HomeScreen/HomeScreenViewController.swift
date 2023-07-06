//
//  HomeScreenViewController.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import UIKit

class HomeScreenViewController: BaseViewController {
    @IBOutlet private var searchStackView: UIStackView!
    @IBOutlet private var searchTextField: UITextField!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var contentStackView: UIStackView!
    @IBOutlet private var emptyContentStackView: UIStackView!
    @IBOutlet private var imageButton: UIButton!

    private lazy var tableViewDataSource = TaskTableViewDataSource()
    var readTaskUseCase = di.resolve(ReadTaskUseCase.self)!
    var updateTaskUseCase = di.resolve(UpdateTaskUseCase.self)!
    var router = di.resolve(TaskScreenRouter.self)!
    private var openTaskDetail: ((TaskEntity) -> Void)!
    private var debouncer: Debouncer!

    override func viewDidLoad() {
        super.viewDidLoad()
        registerObserveTaskNotification()
        debouncer = .init(delay: 0.58, callback: { [weak self] in
            self?.searchTaskToday(with: self?.searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))
        })
    }

    override func configSubView() {
        print(Self.self, #function)
        tableView.configPullToRefreshView()
        tableView.configPullToRefresh { [weak self] in
            self?.refreshTaskToday()
        }

        tableViewDataSource.configTableView(tableView)
        tableViewDataSource.tapInsideCheckBox = { [weak self] taskEntity in
            self?.toogleTaskStatus(taskEntity)
        }
        tableViewDataSource.didSelectItem = { [weak self] taskEntity in
            self?.didSelectItem(taskEntity: taskEntity)
        }
        refreshTaskToday()
    }

    private func didSelectItem(taskEntity: TaskEntity) {
        router.openDetailTask(from: self, taskEntity: taskEntity) { taskEntity in
            print(Self.self, #function, taskEntity)
        }
    }

    private func refreshTaskToday() {
        let today = Date()
        let filter = TaskFilterModel(date: today, keyword: searchTextField.text)
        refreshTask(filter: filter) { [weak self] taskEntities in
            DispatchQueue.main.async {
                self?.tableView.stopPullToRefreshAnimation()
                self?.contentStackView.isHidden = taskEntities?.isEmpty ?? true
                self?.emptyContentStackView.isHidden = !(taskEntities?.isEmpty ?? true)
                self?.tableViewDataSource.setModels(taskEntities ?? [])
            }
        }
    }

    @IBAction private func searchTextFieldChanged(_ sender: Any) {
        print(Self.self, #function)
        debouncer.call()
    }

    private func searchTaskToday(with keyword: String?) {
        let today = Date()
        let filter = TaskFilterModel(date: today, keyword: keyword)
        refreshTask(filter: filter) { [weak self] taskEntities in
            DispatchQueue.main.async {
                self?.tableViewDataSource.setModels(taskEntities ?? [])
            }
        }
    }

    @IBAction private func touchUpInsideFilterButton(_ sender: Any) {
        print(Self.self, #function)
    }

    // MARK: - observeTaskChangeNotification

    private func registerObserveTaskNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(observeTaskChangeNotification), name: .taskChangeNotification, object: nil)
    }

    @objc private func observeTaskChangeNotification() {
        refreshTaskToday()
    }

    private func removeObserveTaskNotification() {
        NotificationCenter.default.removeObserver(self, name: .taskChangeNotification, object: nil)
    }

    deinit {
        removeObserveTaskNotification()
    }
}

extension HomeScreenViewController {
    static func initailize(openTaskDetail: @escaping (TaskEntity) -> Void) -> Self {
        let viewController = initial()
        viewController.openTaskDetail = openTaskDetail
        return viewController
    }
}

extension HomeScreenViewController: ReadTaskViewController {}
extension HomeScreenViewController: UpdateTaskViewController {}
