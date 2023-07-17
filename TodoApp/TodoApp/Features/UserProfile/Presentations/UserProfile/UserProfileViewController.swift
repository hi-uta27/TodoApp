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
    lazy var readTaskUseCase = di.resolve(ReadTaskUseCase.self)!

    override func viewDidLoad() {
        super.viewDidLoad()
        readUserInfo()
        readTask()
        registerObserveTaskNotification()
    }

    private func readUserInfo() {
        displayIndicator(isShow: true)
        userInforUseCase.readUserInfor { [weak self] user in
            DispatchQueue.main.async {
                self?.displayIndicator(isShow: false)
                guard let user = user else { return }
                self?.userNameLabel.text = user.displayName
                if let image = user.image {
                    self?.imageView.sd_setImage(with: image)
                } else {
                    self?.imageView.image = UIImage(named: "UserDefault")
                }
            }
        }
    }

    private func readTask() {
        refreshTask(filter: nil) { [weak self] tasks in
            guard let tasks = tasks else { return }
            let taskLeft = tasks.filter { $0.status == .todo }.count
            let taskDone = tasks.count - taskLeft
            self?.taskLeftButton.setTitle("\(taskLeft) Task left", for: .normal)
            self?.taskDoneButton.setTitle("\(taskDone) Task done", for: .normal)
        }
    }

    @IBAction private func touchUpInsideAppSettingButton(_ sender: Any) {
        print(Self.self, #function)
    }

    @IBAction private func touchUpInsideChangeAccountNameButton(_ sender: Any) {
        presentChangeAccountName(changeAccountNameSuccess: { [weak self] name in
            self?.userNameLabel.text = name
        }, complete: nil)
    }

    @IBAction private func touchUpInsideChangeAccountPasswordButton(_ sender: Any) {
        presentChangePassword(complete: nil)
    }

    @IBAction private func touchUpInsideChangeAccountImageButton(_ sender: Any) {
        presentChangeAccountImage(changeAccountImageSuccess: { [weak self] url in
            self?.imageView.sd_setImage(with: url)
        }, complete: nil)
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

    // MARK: - observeTaskChangeNotification

    private func registerObserveTaskNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(observeTaskChangeNotification), name: .taskChangeNotification, object: nil)
    }

    @objc private func observeTaskChangeNotification() {
        readTask()
    }

    private func removeObserveTaskNotification() {
        NotificationCenter.default.removeObserver(self, name: .taskChangeNotification, object: nil)
    }

    deinit {
        removeObserveTaskNotification()
    }
}

extension UserProfileViewController: ReadTaskViewController {}
