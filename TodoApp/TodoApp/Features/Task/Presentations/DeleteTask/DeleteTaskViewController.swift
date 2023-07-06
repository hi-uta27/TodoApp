//
//  DeleteTaskViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import Foundation

protocol DeleteTaskViewController: ShowAlertViewController {
    var deleteTaskUseCase: DeleteTaskUseCase { get set }
}

extension DeleteTaskViewController {
    func deleteTask(_ taskEntity: TaskEntity) {
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
