//
//  AuthenticationInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/12/23.
//

import Foundation
import Swinject

enum AuthenticationInject {
    static func register(container: Container) {
        container.register(AuthenticationScreenRouter.self) { _, navigationController in
            AuthenticationScreenRouterImpl(navigationController: navigationController)
        }
        registerLogin(container: container)
        registerLogout(container: container)
    }
}

extension AuthenticationInject: LoginInject {}
extension AuthenticationInject: LogoutInject {}
