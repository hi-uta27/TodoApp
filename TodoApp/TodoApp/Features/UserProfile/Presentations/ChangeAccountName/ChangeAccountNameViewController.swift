//
//  ChangeAccountNameViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import UIKit

class ChangeAccountNameViewController: BaseViewController {
    @IBOutlet private var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchUpInsideEditButton(_ sender: Any) {
        print(Self.self, #function)
        if let userName = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !userName.isEmpty {
            print(Self.self, #function, userName)
        } else {
            showAlert(title: "Error", message: "Please enter a user name", actions: [.okAction()])
        }
    }
}

extension UIViewController {
    func presentChangeAccountName() {
        let viewController = ChangeAccountNameViewController.initial()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
}
