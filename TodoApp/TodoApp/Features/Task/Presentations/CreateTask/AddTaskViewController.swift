//
//  CreateTaskViewController.swift
//  TodoApp
//
//  Created by Heligate on 14/06/2023.
//
import UIKit

class AddTaskViewController: BaseViewController {
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var backgroundTitleStackView: UIStackView!
    @IBOutlet private var descriptionTextField: UITextField!
    @IBOutlet private var backgroundDescriptionStackView: UIStackView!
    @IBOutlet private var backgroundContentView: UIView!
    @IBOutlet private var backgroundContentViewConstraint: NSLayoutConstraint!

    private let currentDate = Date()

    private lazy var createTaskUseCase = di.resolve(CreateTaskUseCase.self)!
    private var openTaskAlarm: (() -> Void)?
    private var openCategory: (() -> Void)?
    private var openPriority: (() -> Void)?
    private var createTaskSuccessed: ((TaskEntity) -> Void)!
    private var dateTime: Date = .init()
    private var category: CategoryEntity = AppCategoryModel.defaultCategories[0]
    private var priority: Int = .taskPriorities[0]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.becomeFirstResponder()
        addObserveKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObserver()
    }

    override func configSubView() {
        print(Self.self, #function)
        backgroundContentView.roundCornerMasks(topLeftRadius: true, topRightRadius: true, radius: 16)
    }

    @IBAction private func touchUpInsideTimerButton(_ sender: Any) {
        print(Self.self, #function)
        openTaskAlarm?()
    }

    @IBAction private func touchUpInsideCategoryButton(_ sender: Any) {
        print(Self.self, #function)
        openCategory?()
    }

    @IBAction private func touchUpInsidePriorityButton(_ sender: Any) {
        print(Self.self, #function)
        openPriority?()
    }

    @IBAction private func touchUpInsideCreateTaskButton(_ sender: Any) {
        print(Self.self, #function)
        createTask()
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

    override func shoudClose() -> Bool {
        dismiss(animated: true)
        return false
    }

    private func editingDidBegin(stackView: UIStackView) {
        stackView.setBorder(borderWidth: 1,
                            borderColor: UIColor(named: "979797"),
                            radius: 4,
                            contentInset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }

    private func createTask() {
        do {
            let (title, description, dateTime, category, priority) = try TaskValidator.validateData(
                title: titleTextField.text,
                description: descriptionTextField.text,
                startTime: dateTime, currentDate: currentDate,
                category: category,
                priority: priority)

            createTaskUseCase.createTask(title: title, description: description, startTime: dateTime, category: category, priority: priority) { [weak self] result in
                switch result {
                case .success(let model):
                    self?.createTaskSuccess(with: model)
                case .failure(let failure):
                    self?.createTaskFailure(failure)
                }
            }
        } catch {
            createTaskFailure(error)
        }
    }

    private func createTaskSuccess(with model: TaskEntity) {
        print(Self.self, #function, "Success", model)
        createTaskSuccessed?(model)
        dismiss(animated: true)
    }

    private func createTaskFailure(_ failure: Error) {
        showAlert(title: "Error", message: failure.localizedDescription, actions: [.okAction()])
    }
}

// MARK: - KeyboardNotifications

extension AddTaskViewController: KeyboardNotifications {
    func keyboardWillHideNotification(_ notification: Notification) {
        updateConstraint(0)
    }

    func keyboardWillShowNotification(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        updateConstraint(keyboardSize.height)
    }

    private func updateConstraint(_ contant: CGFloat) {
        backgroundContentViewConstraint.constant = contant
        view.layoutIfNeeded()
    }
}

extension AddTaskViewController {
    static func initialize(openTaskAlarm: @escaping () -> Void,
                           openCategory: @escaping () -> Void,
                           openPriority: @escaping () -> Void,
                           createTaskSuccessed: @escaping (TaskEntity) -> Void) -> Self
    {
        let viewController = initial()
        viewController.openTaskAlarm = openTaskAlarm
        viewController.openCategory = openCategory
        viewController.openPriority = openPriority
        viewController.createTaskSuccessed = createTaskSuccessed
        return viewController
    }
}

// MARK: - TaskScreenDataSource

extension AddTaskViewController: TaskScreenDataSource {
    func didUpdateCategory(_ category: CategoryEntity) {
        self.category = category
    }

    func didUpdatePriority(_ priority: Int) {
        self.priority = priority
    }

    func didUpdateDateTime(_ dateTime: Date) {
        self.dateTime = dateTime
    }
}

extension UIViewController {
    func presentCreateTask(openTaskAlarm: @escaping () -> Void,
                           openCategory: @escaping () -> Void,
                           openPriority: @escaping () -> Void,
                           createTaskSuccessed: @escaping (TaskEntity) -> Void,
                           complete: (() -> Void)?)
    {
        let viewController = AddTaskViewController.initialize(openTaskAlarm: openTaskAlarm,
                                                              openCategory: openCategory,
                                                              openPriority: openPriority,
                                                              createTaskSuccessed: createTaskSuccessed)
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
