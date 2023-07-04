//
//  CreateCategoryViewController.swift
//  TodoApp
//
//  Created by Heligate on 12/06/2023.
//

import UIKit

class CreateCategoryViewController: BaseViewController {
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var backgroundNameStackView: UIStackView!
    @IBOutlet private var chooseIconButton: UIButton!
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var createCategoryButton: UIButton!
    @IBOutlet private var iconButton: UIButton!

    private lazy var collectionViewDataSource = CategoryColorCollectionViewDataSource()
    private lazy var createCategoryUseCase = di.resolve(CreateCategoryUseCase.self)!
    private var createCategorySucceeded: (() -> Void)!

    private let icons = UIImage.categoryIconNames
    private let colors = UIColor.categoryHexColors

    private var selectedIcon: String!
    private var selectedColor: String = UIColor.categoryHexColors[0]

    override func configSubView() {
        print(Self.self, #function)
        backgroundNameStackView.roundCorners(with: 4)
        backgroundNameStackView.border(width: 0.8, color: .white)
        iconButton.roundCorners(with: 6)
        chooseIconButton.roundCorners(with: 6)
        createCategoryButton.roundCorners(with: 4)
        refreshSelectedIcon()

        collectionViewDataSource.configCollectionView(collectionView)
        collectionViewDataSource.didSelectItemAt = { [weak self] color in
            self?.didSelectCategoryColor(color)
        }
        collectionViewDataSource.setData(colors)
        collectionViewDataSource.setSelectedColor(selectedColor)
    }

    @MainActor
    private func didSelectCategoryColor(_ color: String) {
        selectedColor = color
        collectionViewDataSource.setSelectedColor(selectedColor)
    }

    private func refreshSelectedIcon() {
        selectedIcon = icons.randomElement()
        iconButton.setImage(UIImage(named: selectedIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
    }

    private func createCategory() {
        do {
            let (name, icon, color) = try CategoryValidator.validateData(name: nameTextField.text, icon: selectedIcon, color: selectedColor)
            createCategoryUseCase.createCategory(name: name, icon: icon, color: color) { [weak self] error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.createCategoryFailure(error)
                    } else {
                        self?.createCategorySuccess()
                    }
                }
            }
        } catch {
            showAlert(title: "Error", message: error.localizedDescription, actions: [.okAction()])
        }
    }

    private func createCategorySuccess() {
        createCategorySucceeded?()
        dismiss(animated: true)
    }

    private func createCategoryFailure(_ error: Error) {
        print(Self.self, #function, error)
        let tryAgainAction: UIAlertAction = .tryAgainAction { [weak self] _ in
            self?.createCategory()
        }
        showAlert(title: "Error", message: error.localizedDescription, actions: [.cancelAction(), tryAgainAction])
    }

    @IBAction func touchUpInsideChooseIconButton(_ sender: Any) {
        print(Self.self, #function)
        refreshSelectedIcon()
    }

    @IBAction func touchUpInsideCreateCategoryButton(_ sender: Any) {
        print(Self.self, #function)
        createCategory()
    }
}

extension CreateCategoryViewController {
    static func initialize(createCategorySucceeded: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.createCategorySucceeded = createCategorySucceeded
        return viewController
    }
}

extension UIViewController {
    func presentCreateCategory(createCategorySucceeded: @escaping () -> Void, animated flag: Bool = true, completion: (() -> Void)? = nil) {
        let vc = CreateCategoryViewController.initialize(createCategorySucceeded: createCategorySucceeded)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: flag, completion: completion)
    }
}
