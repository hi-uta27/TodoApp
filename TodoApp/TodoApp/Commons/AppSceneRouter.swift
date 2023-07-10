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
    private lazy var onboardingRouter = di.resolve(OnboardingScreenRouter.self, argument: rootNavigationController)!

    func prepareScene() {
        onboardingRouter.openIntroForApp()
    }
}
