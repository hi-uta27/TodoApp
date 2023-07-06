//
//  TaskScreenRouterImpl.swift
//  TodoApp
//
//  Created by Heligate on 22/06/2023.
//

import UIKit

class TaskScreenRouterImpl: NSObject, TaskScreenRouter {
    private var model: TaskScreenModel
    private var navigationController: UINavigationController
    private weak var taskScreenDataSource: TaskScreenDataSource?

    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController ?? .init()
        self.navigationController.modalPresentationStyle = .overFullScreen
        self.model = TaskScreenModel()
    }

    func openAddTask(from parent: UIViewController, complete: @escaping (TaskEntity) -> Void) {
        let viewController = AddTaskViewController.initialize(
            openTaskAlarm: { [weak self] in
                self?.openTaskAlarm()
            },
            openCategory: { [weak self] in
                self?.openChooseCategory()
            },
            openPriority: { [weak self] in
                self?.openTaskPriority()
            },
            createTaskSuccessed: { taskEntity in
                complete(taskEntity)
            })
        taskScreenDataSource = viewController
        navigationController.setViewControllers([viewController], animated: false)
        parent.present(navigationController, animated: true)
    }

    func openDetailTask(from parent: UIViewController, taskEntity: TaskEntity, complete: @escaping (TaskEntity) -> Void) {
        let viewController = DetailTaskViewController.initailize(
            taskEntity: taskEntity,
            openTaskTitle: { [weak self] in
                print(self!, #function, "Open Task Title")
            },
            openTaskTime: { [weak self] in
                self?.openTaskAlarm()
            },
            openTaskCategory: { [weak self] in
                self?.openChooseCategory()
            },
            openTaskPriority: { [weak self] in
                self?.openTaskPriority()
            },
            openSubTask: { [weak self] in
                print(self!, #function, "Open Sub Task")
            },
            editTaskSuccess: { taskEntity in
                complete(taskEntity)
            })
        taskScreenDataSource = viewController
        navigationController.setViewControllers([viewController], animated: false)
        parent.present(navigationController, animated: true)
    }

    deinit {
        print(Self.self, #function)
    }
}

private extension TaskScreenRouterImpl {
    func openTaskAlarm() {
        let viewController = TaskAlarmViewController.initialize(
            day: model.dateTime.day,
            month: model.dateTime.month,
            year: model.dateTime.year,
            didSelectDate: { [weak self] day, month, year in
                self?.model.dateTime.setDate(day: day, month: month, year: year)
            },
            openChooseTime: { [weak self] in
                self?.openChooseTime()
            })

        navigationController.pushSlideUpViewController(viewController)
    }

    func openChooseTime() {
        let viewController = ChooseTimeViewController.initialize(
            hour: model.dateTime.hour,
            minute: model.dateTime.minute,
            didSelectTime: { [weak self] hour, minute in
                self?.model.dateTime.setTime(hour: hour, minute: minute)
                self?.navigationController.popSlideDownToRoot()
                self?.completeSetDateTime()
            })
        navigationController.pushSlideUpViewController(viewController)
    }

    func completeSetDateTime() {
        guard let dateTime = model.dateTime.toDate() else { return }
        taskScreenDataSource?.didUpdateDateTime(dateTime)
    }
}

private extension TaskScreenRouterImpl {
    func openChooseCategory() {
        let viewController = ChooseCategoryViewController.initialize(
            selectedCategory: model.category,
            didSelectCategory: { [weak self] category in
                self?.model.category = category
                self?.navigationController.popSlideDown()
                self?.completeSetCategory()
            })
        navigationController.pushSlideUpViewController(viewController)
    }

    func completeSetCategory() {
        guard let category = model.category else { return }
        taskScreenDataSource?.didUpdateCategory(category)
    }
}

private extension TaskScreenRouterImpl {
    func openTaskPriority() {
        let viewController = TaskPriorityViewController.initialize(
            selectedPriority: model.priority,
            didSelectPriority: { [weak self] priority in
                self?.model.priority = priority
                self?.navigationController.popSlideDown()
                self?.completeSetPriority()
            })
        navigationController.pushSlideUpViewController(viewController)
    }

    func completeSetPriority() {
        guard let priority = model.priority else { return }
        taskScreenDataSource?.didUpdatePriority(priority)
    }
}
