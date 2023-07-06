//
//  DetailTaskViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/5/23.
//

import UIKit

class DetailTaskViewController: BaseViewController {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var dateTimeButton: UIButton!
    @IBOutlet private var categoryTitleLabel: UILabel!
    @IBOutlet private var categoryIconButton: UIButton!
    @IBOutlet private var checkBoxButton: UIButton!
    
    private var defaultTaskEntity: TaskEntity!

    private var taskEntity: TaskEntity!
    private var openTaskTitle: (() -> Void)!
    private var openTaskTime: (() -> Void)!
    private var openTaskCategory: (() -> Void)!
    private var openTaskPriority: (() -> Void)!
    private var openSubTask: (() -> Void)!
    private var editTaskSuccess: ((TaskEntity) -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(with: taskEntity)
    }
    
    private func updateUI(with taskEntity: TaskEntity) {
        titleLabel.text = taskEntity.title
        descriptionLabel.text = taskEntity.descriptions
        let stringFormatDate = "'Today At' HH:mm"
        dateTimeButton.setTitle(taskEntity.startTime.toFormat(stringFormatDate), for: .normal)
        categoryIconButton.setImage(UIImage(named: taskEntity.category.icon), for: .normal)
        categoryTitleLabel.text = taskEntity.category.name
    }
    
    @IBAction private func touchUpInsideRefreshButton(_ sender: Any) {
        taskEntity = defaultTaskEntity
        updateUI(with: taskEntity)
    }
    
    @IBAction private func touchUpInsideCheckBoxButton(_ sender: Any) {
        let taskEntity = taskEntity.status.toggle()
        checkBoxButton.isSelected = taskEntity == .completed
    }
    
    @IBAction private func touchUpInsideEditTitleButton(_ sender: Any) {
        openTaskTitle?()
    }
    
    @IBAction private func touchUpInsideDateTimeButton(_ sender: Any) {
        openTaskTime?()
    }
    
    @IBAction private func touchUpInsideCategoryButton(_ sender: Any) {
        openTaskCategory?()
    }
    
    @IBAction private func touchUpInsidePriorityButton(_ sender: Any) {
        openTaskPriority?()
    }
    
    @IBAction private func touchUpInsideSubTaskButton(_ sender: Any) {
        openSubTask?()
    }
    
    @IBAction private func touchUpInsideDeleteButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    @IBAction private func touchUpInsideEditTaskButton(_ sender: Any) {
        print(Self.self, #function)
    }
    
    override func shoudClose() -> Bool {
        dismiss(animated: true)
        return false
    }
}

extension DetailTaskViewController {
    static func initailize(taskEntity: TaskEntity,
                           openTaskTitle: @escaping () -> Void,
                           openTaskTime: @escaping () -> Void,
                           openTaskCategory: @escaping () -> Void,
                           openTaskPriority: @escaping () -> Void,
                           openSubTask: @escaping () -> Void,
                           editTaskSuccess: @escaping (TaskEntity) -> Void) -> Self
    {
        let viewController = initial()
        viewController.defaultTaskEntity = taskEntity
        viewController.taskEntity = taskEntity
        viewController.openTaskTitle = openTaskTitle
        viewController.openTaskTime = openTaskTime
        viewController.openTaskCategory = openTaskCategory
        viewController.openTaskPriority = openTaskPriority
        viewController.openSubTask = openSubTask
        viewController.editTaskSuccess = editTaskSuccess
        return viewController
    }
}

extension DetailTaskViewController: TaskScreenDataSource {
    func didUpdateDateTime(_ dateTime: Date) {
//        taskEntity.startTime = dateTime
    }
    
    func didUpdateCategory(_ category: CategoryEntity) {
//        taskEntity.category = category
    }
    
    func didUpdatePriority(_ priority: Int) {
//        taskEntity.priority = priority
    }
}
