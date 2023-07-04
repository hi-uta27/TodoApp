//
//  ReadTaskViewController.swift
//  TodoApp
//
//  Created by Heligate on 27/06/2023.
//

import Foundation

protocol ReadTaskViewController: ShowAlertViewController {
    var readTaskUseCase: ReadTaskUseCase { get set }
}

extension ReadTaskViewController {
    func refreshTask(filter: TaskFilter, refreshTaskSuccess: @escaping ([TaskEntity]?) -> Void) {
        readTaskUseCase.readTask(filter: filter) { [weak self] result in
            switch result {
            case .success(let tasks):
                refreshTaskSuccess(tasks)
            case .failure(let failure):
                self?.refreshTaskFailure(failure)
            }
        }
    }

    private func refreshTaskFailure(_ failure: Error) {
        showAlert(title: "Error", message: failure.localizedDescription, actions: [.okAction()])
    }
}
