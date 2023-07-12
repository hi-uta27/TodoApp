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

    func openLogin(openHomeScreen: @escaping () -> Void) {
        let viewController = LoginViewController.initial(openRegisterScreen: { [weak self] in
            self?.openRegisterScreen(openHomeScreen: openHomeScreen)
        }, openHomeScreen: {
            openHomeScreen()
        })

        navigationController.pushViewController(viewController, animated: true)
    }
}

private extension AuthenticationScreenRouterImpl {
    func openRegisterScreen(openHomeScreen: @escaping () -> Void) {
        let viewController = RegisterViewController.initial {
            openHomeScreen()
        }

        navigationController.pushViewController(viewController, animated: true)
    }
}

private extension AuthenticationScreenRouterImpl {
    func openHomeScreen() {
        //
    }
}
