//
//  IntroInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/10/23.
//

import Foundation
import Swinject

enum IntroInject {
    static func register(container: Container) {
        container.register(OnboardingScreenRouter.self) { _, navigationController in
            OnboardingScreenRouterImpl(navigationController: navigationController)
        }
    }
}
