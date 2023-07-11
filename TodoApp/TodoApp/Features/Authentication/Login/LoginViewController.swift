//
//  LoginViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/11/23.
//

import FirebaseAuth
import UIKit

class LoginViewController: BaseViewController {
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    private lazy var firebaseAuth = Auth.auth()
    private var openRegisterScreen: (() -> Void)!
    private var openHomeScreen: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        userNameTextField.text = "tavanhieun@gmail.com"
        passwordTextField.text = "123456"
        #endif
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
        displayIndicator(isShow: true)
        firebaseAuth.signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                if let error = error {
                    self?.showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
                } else {
                    self?.openHomeScreen?()
                }
            }
        }
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
    static func initial(openRegisterScreen: @escaping () -> Void, openHomeScreen: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.openRegisterScreen = openRegisterScreen
        viewController.openHomeScreen = openHomeScreen
        return viewController
    }
}
