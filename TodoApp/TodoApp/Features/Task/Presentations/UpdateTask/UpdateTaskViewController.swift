//
//  UpdateTaskViewController.swift
//  TodoApp
//
//  Created by Heligate on 27/06/2023.
//

import Foundation

protocol UpdateTaskViewController: ShowAlertViewController {
    var updateTaskUseCase: UpdateTaskUseCase { get set }
}

extension UpdateTaskViewController {
    func toogleTaskStatus(_ taskEntity: TaskEntity) {
        updateTaskUseCase.toogleTaskStatus(taskEntity) { [weak self] error in
            guard let error = error else { return }
            self?.toogleTaskFailure(error)
        }
    }

    private func toogleTaskFailure(_ failure: Error) {
        showAlert(title: "Error", message: failure.localizedDescription, actions: [.okAction()])
    }
}
