//
//  AuthenticationScreenRouterImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/12/23.
//

import UIKit

class AuthenticationScreenRouterImpl: AuthenticationScreenRouter {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }

    func openLogin() {
        let viewController = LoginViewController.initial(openRegisterScreen: { [weak self] in
            self?.openRegister()
        }, openHomeScreen: { [weak self] in
            self?.openHomeScreen()
        })
        navigationController.pushViewController(viewController, animated: true)
    }

    func openRegister() {
        let viewController = RegisterViewController.initial { [weak self] in
            self?.openHomeScreen()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}

private extension AuthenticationScreenRouterImpl {
    func openHomeScreen() {
        let viewController = MainTabbarViewController.initial()
        navigationController.setViewControllers([viewController], animated: true)
    }
}
