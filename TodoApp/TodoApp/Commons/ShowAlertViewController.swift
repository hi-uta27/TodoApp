//
//  Alert.swift
//  TodoApp
//
//  Created by Heligate on 14/06/2023.
//

import UIKit

protocol ShowAlertViewController: UIViewController {}

extension ShowAlertViewController {
    func showAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction] = [.cancelAction()]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}
