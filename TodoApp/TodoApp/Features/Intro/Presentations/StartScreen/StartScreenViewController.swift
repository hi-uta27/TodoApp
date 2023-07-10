//
//  StartScreenViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/9/23.
//

import UIKit

class StartScreenViewController: BaseViewController {
    private var openLogin: (() -> Void)!
    private var openCreateAccount: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchUpInsideLoginButton(_ sender: Any) {
        openLogin?()
    }

    @IBAction private func touchUpInsideCreateAccountButton(_ sender: Any) {
        openCreateAccount?()
    }
}

extension StartScreenViewController {
    static func initial(openLogin: @escaping () -> Void, openCreateAccount: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.openLogin = openLogin
        viewController.openCreateAccount = openCreateAccount
        return viewController
    }
}
