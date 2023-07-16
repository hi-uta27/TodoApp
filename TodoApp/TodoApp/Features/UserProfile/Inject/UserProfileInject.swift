//
//  UserProfileInject.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation
import Swinject

enum UserProfileInject {
    static func register(container: Container) {
        registerChangeAccount(container: container)
    }
}

extension UserProfileInject: ChangeAccountNameInject {}
