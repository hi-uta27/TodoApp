//
//  RegisterViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/12/23.
//

import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var confirmPasswordTextField: UITextField!
    @IBOutlet private var showHidePasswordButton: UIButton!
    @IBOutlet private var showHideConfirmPasswordButton: UIButton!

    private var openHomeScreen: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchUpInsideRegisterButton(_ sender: Any) {
        do {
            let (email, password) = try UserValidator.validateData(
                email: userNameTextField.text,
                password: passwordTextField.text,
                confirmPassword: confirmPasswordTextField.text)

//            registerWith(email: email, password: password, registerSuccessed: { [weak self] in
//                self?.navigationController?.popViewController(animated: true)
//            })
        } catch {
            showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
        }
    }

    @IBAction private func touchUpInsideLoginWithGoogleButton(_ sender: Any) {
//        loginWithGoogle { [weak self] in
//            self?.openHomeScreen?()
//        }
    }

    @IBAction private func touchUpInsideLoginWithAppleButton(_ sender: Any) {
        loginWithBiometric { [weak self] in
            self?.openHomeScreen?()
        }
    }

    @IBAction private func touchUpInsideShowHidePassswordButton(_ sender: Any) {
        showHidePasswordButton.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }

    @IBAction private func touchUpInsideShowHideConfirmPasswordButton(_ sender: Any) {
        showHideConfirmPasswordButton.isSelected.toggle()
        confirmPasswordTextField.isSecureTextEntry.toggle()
    }
}

extension RegisterViewController {
    static func initial(openHomeScreen: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.openHomeScreen = openHomeScreen
        return viewController
    }
}

extension RegisterViewController: BiometricAuthentication {}
