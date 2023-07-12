//
//  RegisterViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/12/23.
//

import FirebaseAuth
import GoogleSignIn
import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var confirmPasswordTextField: UITextField!

    lazy var firebaseAuth = Auth.auth()
    lazy var googleSignIn = GIDSignIn.sharedInstance
    private var openRegisterScreen: (() -> Void)!
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

            loginWith(email: email, password: password, loginSuccesed: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
        } catch {
            showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
        }
    }

    @IBAction private func touchUpInsideLoginWithGoogleButton(_ sender: Any) {
        loginWithGoogle { [weak self] in
            self?.openHomeScreen?()
        }
    }

    @IBAction private func touchUpInsideLoginWithAppleButton(_ sender: Any) {
        loginWithBiometric { [weak self] in
            self?.openHomeScreen?()
        }
    }
}

extension RegisterViewController {
    static func initial(openRegisterScreen: @escaping () -> Void, openHomeScreen: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.openRegisterScreen = openRegisterScreen
        viewController.openHomeScreen = openHomeScreen
        return viewController
    }
}

extension RegisterViewController: FirebaseAuthentication {}
extension RegisterViewController: BiometricAuthentication {}
