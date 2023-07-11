//
//  LoginViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/11/23.
//

import FirebaseAuth
import GoogleSignIn
import UIKit

class LoginViewController: BaseViewController {
    @IBOutlet private var userNameTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    lazy var firebaseAuth = Auth.auth()
    lazy var googleSignIn = GIDSignIn.sharedInstance
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
            loginWith(email: email, password: password, loginSuccesed: { [weak self] in
                self?.openHomeScreen?()
            })
        } catch {
            showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
        }
    }

    @IBAction private func touchUpInsideLoginWithGoogleButton(_ sender: Any) {
        loginWithGoogle(loginSuccesed: { [weak self] in
            self?.openHomeScreen?()
        })
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

// MARK: Firebase Email

extension LoginViewController: FirebaseAuthentication {}
