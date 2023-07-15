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

    private lazy var loginUseCase = di.resolve(LoginUseCase.self, argument: self as UIViewController)!
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
            loginWith(email: email, password: password)
        } catch {
            showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
        }
    }

    private func loginWith(email: String, password: String) {
        displayIndicator(isShow: true)
        loginUseCase.loginWith(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                switch result {
                case .success:
                    self?.openHomeScreen?()
                case .failure(let failure):
                    self?.showAlert(title: "Error", message: failure.localizedDescription, actions: [.okAction()])
                }
            }
        }
    }

    @IBAction private func touchUpInsideLoginWithGoogleButton(_ sender: Any) {
        displayIndicator(isShow: true)
        loginUseCase.loginWithGoogle { [weak self] result in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                switch result {
                case .success:
                    self?.openHomeScreen?()
                case .failure(let failure):
                    self?.showAlert(title: "Error", message: failure.localizedDescription, actions: [.okAction()])
                }
            }
        }
    }

    @IBAction private func touchUpInsideLoginWithAppleButton(_ sender: Any) {
        print(Self.self, #function, "This feature is under developing")
        // TODO: - Update when have apple develop account
//        loginWithBiometric { [weak self] result in
//            switch result {
//            case .success:
//                self?.openHomeScreen?()
//            case .failure(let failure):
//                self?.showAlert(title: "Error", message: failure.localizedDescription, actions: [.okAction()])
//            }
//        }
    }

    @IBAction private func touchUpInsideRegisterButton(_ sender: Any) {
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

extension LoginViewController: BiometricAuthentication {}
