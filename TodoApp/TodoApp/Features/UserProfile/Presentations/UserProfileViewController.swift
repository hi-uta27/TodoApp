//
//  UserProfileViewController.swift
//  TodoApp
//
//  Created by Heligate on 30/06/2023.
//

import SDWebImage
import UIKit

class UserProfileViewController: BaseViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var taskLeftButton: UIButton!
    @IBOutlet private var taskDoneButton: UIButton!

    private lazy var logoutUseCase = di.resolve(LogoutUseCase.self)!
    private lazy var userInforUseCase = di.resolve(UserInforUseCase.self)!

    private var openChangeAppSetting: (() -> Void)!
    private var openChangeAccountName: (() -> Void)!
    private var openChangeAccountPassword: (() -> Void)!
    private var openChangeAccountImage: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        readUserInfo()
    }

    private func readUserInfo() {
        displayIndicator(isShow: true)
        userInforUseCase.readUserInfor { [weak self] user in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                guard let user = user else { return }
                self?.userNameLabel.text = user.displayName
                self?.imageView.sd_setImage(with: user.image)
            }
        }
    }

    @IBAction private func touchUpInsideAppSettingButton(_ sender: Any) {
        openChangeAppSetting?()
    }

    @IBAction private func touchUpInsideChangeAccountNameButton(_ sender: Any) {
        openChangeAccountName?()
    }

    @IBAction private func touchUpInsideChangeAccountPasswordButton(_ sender: Any) {
        openChangeAccountPassword?()
    }

    @IBAction private func touchUpInsideChangeAccountImageButton(_ sender: Any) {
        openChangeAccountImage?()
    }

    @IBAction private func touchUpInsideAboutUSButton(_ sender: Any) {
        print(Self.self, #function, "This feature is under developing")
    }

    @IBAction private func touchUpInsideFAQButton(_ sender: Any) {
        print(Self.self, #function, "This feature is under developing")
    }

    @IBAction private func touchUpInsideHelpAndFeedbackButton(_ sender: Any) {
        print(Self.self, #function, "This feature is under developing")
    }

    @IBAction private func touchUpInsideSupportUSButton(_ sender: Any) {
        print(Self.self, #function, "This feature is under developing")
    }

    @IBAction private func touchUpInsideLogoutButton(_ sender: Any) {
        showAlert(title: "Notification",
                  message: "Do you want logout of this account?",
                  actions: [.cancelAction(), .okAction(handler: { [weak self] _ in
                      self?.logout()
                  })])
    }

    private func logout() {
        displayIndicator(isShow: true)
        logoutUseCase.logout { [weak self] error in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                if let error = error {
                    self?.showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
                } else {
                    AppSceneRouter.shared.prepareScene()
                }
            }
        }
    }
}

extension UserProfileViewController {
    static func initial(openChangeAppSetting: @escaping () -> Void,
                        openChangeAccountName: @escaping () -> Void,
                        openChangeAccountPassword: @escaping () -> Void,
                        openChangeAccountImage: @escaping () -> Void) -> Self
    {
        let viewController = initial()
        viewController.openChangeAppSetting = openChangeAppSetting
        viewController.openChangeAccountName = openChangeAccountName
        viewController.openChangeAccountPassword = openChangeAccountPassword
        viewController.openChangeAccountImage = openChangeAccountImage
        return viewController
    }
}
