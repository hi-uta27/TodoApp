//
//  DeleteTaskViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import UIKit

protocol DeleteTaskViewController: ShowAlertViewController {
    var deleteTaskUseCase: DeleteTaskUseCase { get set }
}

extension DeleteTaskViewController {
    func showDeleteAlert(_ taskEntity: TaskEntity) {
        let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: { [weak self] _ in
            self?.deleteTask(taskEntity)
        })
        showAlert(title: "Delete Task", message: "Are You sure you want to delete this task? \nTask title : \(taskEntity.title)", actions: [.cancelAction(), deleteAction])
    }

    private func deleteTask(_ taskEntity: TaskEntity) {
        deleteTaskUseCase.deleteTask(taskEntity) { [weak self] error in
            switch error {
            case .none:
                self?.dismiss(animated: true)
            case .some(let error):
                self?.deleteTaskFailure(error)
            }
        }
    }

    private func deleteTaskFailure(_ failure: Error) {
        showAlert(title: "Error", message: failure.localizedDescription, actions: [.okAction()])
    }
}
