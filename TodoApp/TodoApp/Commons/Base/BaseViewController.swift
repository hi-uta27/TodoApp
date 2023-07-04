//
//  BaseViewController.swift
//  TodoApp
//
//  Created by Heligate on 06/06/2023.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configSubView()
    }

    func configSubView() {
        print(Self.self, #function)
    }

    func shoudClose() -> Bool {
        return true
    }

    @IBAction private func touchUpInsideCloseButton(_ sedner: UIButton?) {
        DispatchQueue.main.async {
            guard self.shoudClose() else { return }
            if let nav = self.navigationController {
                nav.self.popViewController(animated: true)
            } else {
                self.dismiss(animated: true) { [weak self] in
                    self?.viewDidDisappear(true)
                }
            }
        }
    }

    func displayIndicator(isShow: Bool) {
        if isShow {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
}

extension BaseViewController {
    static func initial() -> Self {
        let storyboard = UIStoryboard(name: "\(Self.self)", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
        return viewController
    }
}

extension BaseViewController: ShowAlertViewController {}
