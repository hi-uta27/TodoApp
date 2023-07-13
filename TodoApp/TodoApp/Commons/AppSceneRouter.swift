//
//  AppSceneRouter.swift
//  TodoApp
//
//  Created by Heligate on 06/06/2023.
//

import Firebase
import UIKit

class AppSceneRouter {
    static let shared = AppSceneRouter()
    private(set) var rootNavigationController: UINavigationController = .init()
    private lazy var onboardingRouter = di.resolve(OnboardingScreenRouter.self, argument: rootNavigationController)!
    private lazy var userInfoUseCase = di.resolve(UserInforUseCase.self)!

    func prepareScene() {
        userInfoUseCase.readUserInfor { [weak self] user in
            if user == nil {
                self?.onboardingRouter.openIntroForApp()
            } else {
                let viewController = MainTabbarViewController.initial()
                self?.rootNavigationController.setViewControllers([viewController], animated: true)
            }
        }
    }
}
