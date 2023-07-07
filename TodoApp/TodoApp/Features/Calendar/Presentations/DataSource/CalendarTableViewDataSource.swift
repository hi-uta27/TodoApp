//
//  CalendarTableViewDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/7/23.
//

import UIKit

class CalendarTableViewDataSource: NSObject {
    private weak var tableView: UITableView?
    private var models: [TaskEntity] = []

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
        self.models = models.filter { $0.status == .todo }
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension CalendarTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        let taskEntity = models[indexPath.row]

        cell.binding(taskEntity)
        cell.tapInsideCheckBox = { [weak self] in
            self?.tapInsideCheckBox?(taskEntity)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate

extension CalendarTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if let title = TaskStatus(rawValue: section)?.description {
//            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TaskHeader.identifier) as! TaskHeader
//            header.binding(title)
//            return header
//        } else {
//            return nil
//        }
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let taskEntity = models[indexPath.row]
        didSelectItem?(taskEntity)
    }
}
