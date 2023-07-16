//
//  ChangeAccountPasswordViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import UIKit

class ChangeAccountPasswordViewController: BaseViewController {
    @IBOutlet private var oldPasswordTextField: UITextField!
    @IBOutlet private var newPasswordTextField: UITextField!

    private lazy var changePasswordUseCase = di.resolve(ChangePasswordUseCase.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchUpInsideEditButton(_ sender: Any) {
        print(Self.self, #function)
        if let oldPassword = validate(oldPasswordTextField),
           let newPassword = validate(newPasswordTextField)
        {
            print(Self.self, #function, oldPassword, newPassword)
        } else {
            showAlert(title: "Error", message: "Please enter password", actions: [.okAction()])
        }
    }

    private func validate(_ textField: UITextField) -> String? {
        if let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
            return text
        } else {
            return nil
        }
    }

    private func changePassword(_ password: String) {
        displayIndicator(isShow: true)
        changePasswordUseCase.changePassword(password) { [weak self] error in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                if let error = error {
                    self?.showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
                } else {
                    self?.dismiss(animated: true)
                }
            }
        }
    }
}

extension UIViewController {
    func presentChangePassword(complete: (() -> Void)?) {
        let viewController = ChangeAccountPasswordViewController.initial()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: complete)
    }
}
