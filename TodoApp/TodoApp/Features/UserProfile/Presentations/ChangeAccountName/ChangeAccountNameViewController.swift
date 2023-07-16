//
//  ChangeAccountNameViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import UIKit

class ChangeAccountNameViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIViewController {
    func presentChangeAccountName() {
        let viewController = ChangeAccountNameViewController.initial()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
