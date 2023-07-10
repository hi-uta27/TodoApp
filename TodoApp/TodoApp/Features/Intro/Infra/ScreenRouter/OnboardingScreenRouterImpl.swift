//
//  OnboardingScreenRouterImpl.swift
//  TodoApp
//
//  Created by TaHieu on 7/10/23.
//

import UIKit

class OnboardingScreenRouterImpl: OnboardingScreenRouter {
    private var navigationController: UINavigationController
    private var isFirstInstall: Bool {
        get {
            return UserDefaults.standard.string(forKey: "OnboardingScreenRouter_IsFirstInstall") == nil ? true : false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "OnboardingScreenRouter_IsFirstInstall")
        }
    }

    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
    }

    func openIntroForApp() {
        openIntroScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if let isFirstInstall = self?.isFirstInstall, isFirstInstall {
                self?.openOnboardingScreen()
            } else {
                self?.openStartScreen()
            }
        }
    }

    private func openIntroScreen() {
        let viewController = IntroViewController.initial()
        navigationController.setViewControllers([viewController], animated: true)
    }

    private func openOnboardingScreen() {
        let viewController = OnboardingViewController.initial { [weak self] in
            self?.openStartScreen()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}

private extension OnboardingScreenRouterImpl {
    func openStartScreen() {
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
