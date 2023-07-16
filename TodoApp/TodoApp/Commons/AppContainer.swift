//
//  AppContainer.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import Swinject
import UIKit

let di = Container()

enum AppContainer {
    static func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        CategoryInject.register(container: di)
        TaskInject.register(container: di)
        IntroInject.register(container: di)
        AuthenticationInject.register(container: di)
        UserProfileInject.register(container: di)
        return true
    }
}
