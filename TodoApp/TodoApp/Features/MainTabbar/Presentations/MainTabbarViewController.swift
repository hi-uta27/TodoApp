//
//  MainTabbarViewController.swift
//  TodoApp
//
//  Created by Heligate on 29/06/2023.
//

import UIKit

class MainTabbarViewController: UIViewController {
    @IBOutlet private var tabbarButtons: [UIButton]!
    private weak var mainTabBarController: UITabBarController?

    private var router: TaskScreenRouter!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarButtons.selectedIndex = 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedTabbarController" {
            mainTabBarController = segue.destination as? MainTabbarController
        }
    }

    @IBAction private func touchUpInsideTabbarButton(_ sender: UIButton) {
        if let index = tabbarButtons.firstIndex(of: sender) {
            mainTabBarController?.selectedIndex = index
            tabbarButtons.selectedIndex = index
        }
    }

    @IBAction private func touchUpInsideAddButton(_ sender: Any) {
        router = di.resolve(TaskScreenRouter.self)!
        router.openAddTask(from: self) { taskEntity in
            print(Self.self, #function, taskEntity)
        }
    }
}

extension MainTabbarViewController {
    static func initial() -> Self {
        let storyboard = UIStoryboard(name: "\(Self.self)", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "\(Self.self)") as! Self
        return viewController
    }
}
