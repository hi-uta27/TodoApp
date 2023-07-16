//
//  ChangeAccountNameViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import UIKit

class ChangeAccountNameViewController: BaseViewController {
    @IBOutlet private var textField: UITextField!

    private lazy var changeAccountNameUseCase = di.resolve(ChangeAccountNameUseCase.self)!
    private var changeAccountNameSuccess: ((String) -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchUpInsideEditButton(_ sender: Any) {
        print(Self.self, #function)
        if let name = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty {
            changeAccountName(name)
        } else {
            showAlert(title: "Error", message: "Please enter a user name", actions: [.okAction()])
        }
    }

    private func changeAccountName(_ name: String) {
        displayIndicator(isShow: true)
        changeAccountNameUseCase.changeAccountName(name) { [weak self] result in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                switch result {
                case .success(let name):
                    self?.changeAccountNameSuccess?(name)
                    self?.dismiss(animated: true)
                case .failure(let failure):
                    self?.showAlert(title: "Error", message: failure.localizedDescription, actions: [.okAction()])
                }
            }
        }
    }
}

extension ChangeAccountNameViewController {
    static func initial(changeAccountNameSuccess: @escaping (String) -> Void) -> Self {
        let viewController = initial()
        viewController.changeAccountNameSuccess = changeAccountNameSuccess
        return viewController
    }
}

extension UIViewController {
    func presentChangeAccountName(changeAccountNameSuccess: @escaping (String) -> Void, complete: (() -> Void)?) {
        let viewController = ChangeAccountNameViewController.initial(changeAccountNameSuccess: changeAccountNameSuccess)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true, completion: complete)
    }
}
