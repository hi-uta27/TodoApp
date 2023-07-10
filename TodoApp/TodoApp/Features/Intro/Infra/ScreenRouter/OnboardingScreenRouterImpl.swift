//
//  OnboardingScreenRouterImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/10/23.
//

import UIKit

class OnboardingScreenRouterImpl: OnboardingScreenRouter {
    private var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func openOnboarding() {
        let viewController = OnboardingViewController.initial { [weak self] in
            self?.openGetStarted()
        }
        navigationController.setViewControllers([viewController], animated: true)
    }
}

private extension OnboardingScreenRouterImpl {
    func openGetStarted() {
        let viewController = StartScreenViewController.initial(openLogin: { [weak self] in
            self?.openLogin()
        }, openCreateAccount: { [weak self] in
            self?.openCreateAccount()
        })
        navigationController.pushViewController(viewController, animated: true)
    }

    func openLogin() {
        // TODO: - Update later
    }

    func openCreateAccount() {
        // TODO: - Update later
    }
}
