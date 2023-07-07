//
//  TaskTitleViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/6/23.
//

import UIKit

class TaskTitleViewController: BaseViewController {
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var backgroundTitleStackView: UIStackView!
    @IBOutlet private var descriptionTextField: UITextField!
    @IBOutlet private var backgroundDescriptionStackView: UIStackView!

    private var taskTitle: String!
    private var descriptions: String?
    private var editTask: ((String, String?) -> Void)!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
    }

    override func configSubView() {
        super.configSubView()
        titleTextField.text = taskTitle
        descriptionTextField.text = descriptions
    }

    @IBAction private func touchUpInsideEditButton(_ sender: Any) {
        do {
            let taskTitle = try TaskValidator.validateTitle(titleTextField.text)
            let descriptions = try TaskValidator.validateDescription(descriptionTextField.text)
            editTask?(taskTitle, descriptions)
        } catch {
            showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
        }
    }

    @IBAction private func editingDidBeginTitleTextField(_ sender: Any) {
        editingDidBegin(stackView: backgroundTitleStackView)
    }

    @IBAction private func editingDidEndTitleTextField(_ sender: Any) {
        backgroundTitleStackView.setBorder()
    }

    @IBAction private func editingDidBeginDescrriptionTextField(_ sender: Any) {
        editingDidBegin(stackView: backgroundDescriptionStackView)
    }

    @IBAction private func editingDidEndDescriptionTextField(_ sender: Any) {
        backgroundDescriptionStackView.setBorder()
    }

    private func editingDidBegin(stackView: UIStackView) {
        stackView.setBorder(borderWidth: 1,
                            borderColor: UIColor(named: "979797"),
                            radius: 4,
                            contentInset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }

    override func shoudClose() -> Bool {
        navigationController?.popSlideDown()
        return false
    }
}

extension TaskTitleViewController {
    static func initial(taskTitle: String, descriptions: String?, editTask: @escaping (String, String?) -> Void) -> Self {
        let viewController = initial()
        viewController.taskTitle = taskTitle
        viewController.descriptions = descriptions
        viewController.editTask = editTask
        return viewController
    }
}
