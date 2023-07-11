//
//  LoginViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/11/23.
//

import UIKit

class LoginViewController: BaseViewController {
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    private var openRegisterScreen: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchUpInsideLoginButton(_ sender: Any) {
        do {
            let (email, password) = try UserValidator.validateData(email: userNameTextField.text, password: passwordTextField.text)
            login(with: email, password: password)
        } catch {
            showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
        }
    }

    private func login(with email: String, password: String) {
        print(Self.self, #function, email, password)
    }

    @IBAction private func touchUpInsideLoginWithGoogleButton(_ sender: Any) {
        print(Self.self, #function)
    }

    @IBAction private func touchUpInsideLoginWithAppleButton(_ sender: Any) {
        print(Self.self, #function)
    }

    @IBAction private func touchUpInsideRegisterButton(_ sender: Any) {
        print(Self.self, #function)
        openRegisterScreen?()
    }
}

extension LoginViewController {
    static func initial(openRegisterScreen: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.openRegisterScreen = openRegisterScreen
        return viewController
    }
}
