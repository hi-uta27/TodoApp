//
//  AppSceneRouter.swift
//  TodoApp
//
//  Created by Heligate on 06/06/2023.
//

import UIKit

class AppSceneRouter {
    static let shared = AppSceneRouter()
    private(set) var rootNavigationController: UINavigationController = .init()

    func prepareScene() {
        let viewController = OnboardingViewController.initial()
        rootNavigationController.viewControllers = [viewController]
    }
}
