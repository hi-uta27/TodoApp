//
//  TaskSceneRouter.swift
//  TodoApp
//
//  Created by Heligate on 22/06/2023.
//

import UIKit

protocol TaskScreenRouter {
    func openAddTask(from parent: UIViewController, complete: @escaping (TaskEntity) -> Void)
}
