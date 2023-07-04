//
//  TaskTableViewDataSource.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import UIKit

class TaskTableViewDataSource: NSObject {
    private weak var tableView: UITableView?
    private var modelsTodo: [TaskEntity] = []
    private var modelsCompleted: [TaskEntity] = []

    var tapInsideCheckBox: ((TaskEntity) -> Void)!
    var didSelectItem: ((TaskEntity) -> Void)!

    func configTableView(_ tableView: UITableView) {
        tableView.register(.init(nibName: TaskHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: TaskHeader.identifier)
        tableView.register(.init(nibName: TaskCell.identifier, bundle: nil), forCellReuseIdentifier: TaskCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView = tableView
    }

    func setModels(_ models: [TaskEntity]) {
        modelsTodo = models.filter { $0.status == .todo }
        modelsCompleted = models.filter { $0.status == .completed }
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension TaskTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        TaskStatus.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TaskStatus(rawValue: section) {
        case .todo:
            return modelsTodo.count
        case .completed:
            return modelsCompleted.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var taskEntity: TaskEntity

        switch TaskStatus(rawValue: indexPath.section) {
        case .todo:
            taskEntity = modelsTodo[indexPath.row]
        case .completed:
            taskEntity = modelsCompleted[indexPath.row]
        default:
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell

        cell.binding(taskEntity)
        cell.tapInsideCheckBox = { [weak self] in
            self?.tapInsideCheckBox?(taskEntity)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TaskTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let title = TaskStatus(rawValue: section)?.description {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskHeader.identifier) as! TaskHeader
            header.binding(title)
            return header
        } else {
            return nil
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(Self.self, #function)
        let taskEntity: TaskEntity
        switch TaskStatus(rawValue: indexPath.section) {
        case .todo:
            taskEntity = modelsTodo[indexPath.row]
        case .completed:
            taskEntity = modelsCompleted[indexPath.row]
        default:
            return
        }
        didSelectItem?(taskEntity)
    }
}
