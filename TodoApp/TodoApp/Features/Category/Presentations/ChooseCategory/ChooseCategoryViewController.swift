//
//  ChooseCategoryViewController.swift
//  TodoApp
//
//  Created by Heligate on 08/06/2023.
//

import UIKit

class ChooseCategoryViewController: BaseViewController {
    @IBOutlet private var button: UIButton!
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var collectionView: UICollectionView!

    private lazy var collectionViewDataSource = CategoryCollectionViewDataSource()
    private lazy var readCategoryUseCase = di.resolve(ReadCategoryUseCase.self)!

    private var selectedCategory: CategoryEntity?
    var didSelectCategory: ((CategoryEntity) -> Void)?

    override func configSubView() {
        print(Self.self, #function)
        button.roundCorners(with: 4)
        backgroundView.roundCorners(with: 4)
        collectionViewDataSource.configCollectionView(collectionView)
        collectionViewDataSource.didSelectItemAt = { [weak self] category in
            print(Self.self, #function, category)
            self?.didSelectedCatgory(category: category)
        }
        readCategory()
    }

    @MainActor
    func didSelectedCatgory(category: CategoryEntity) {
        if category is CreateCategoryModel {
            selectedCategory = nil
            openCreateNewCategory()
        } else {
            selectedCategory = category
        }
        collectionViewDataSource.selectedCategory = selectedCategory
    }

    private func readCategory() {
        readCategoryUseCase.readCategory { [weak self] result in
            switch result {
            case .success(let models):
                self?.readCategorySuccess(with: models)
            case .failure(let failure):
                self?.readCategoryFailure(failure)
            }
        }
    }

    private func readCategorySuccess(with models: [CategoryEntity]) {
        let createCategoryModel = CreateCategoryModel()
        let categoryModels: [CategoryEntity] = models + [createCategoryModel]
        collectionViewDataSource.selectedCategory = selectedCategory
        collectionViewDataSource.setModels(categoryModels)
    }

    private func readCategoryFailure(_ failure: Error) {
        print(Self.self, #function, failure)
    }

    private func openCreateNewCategory() {
        print(Self.self, #function)
        presentCreateCategory(createCategorySucceeded: { [weak self] in
            self?.readCategory()
        })
    }

    @IBAction func touchUpInsideAddCategoryButton(_ sender: Any) {
        print(Self.self, #function)
        guard let categorySelected = selectedCategory else { return }
        didSelectCategory?(categorySelected)
    }

    override func shoudClose() -> Bool {
        navigationController?.popSlideDown()
        return false
    }
}

extension ChooseCategoryViewController {
    static func initialize(selectedCategory: CategoryEntity?,
                           didSelectCategory: ((CategoryEntity) -> Void)?) -> Self
    {
        let viewController = initial()
        viewController.selectedCategory = selectedCategory
        viewController.didSelectCategory = didSelectCategory
        return viewController
    }
}

extension UIViewController {
    func presentChooseCategory(selectedCategory: CategoryEntity?,
                               didSelectCategory: ((CategoryEntity) -> Void)?,
                               animated flag: Bool = true,
                               completion: (() -> Void)? = nil)
    {
        let vc = ChooseCategoryViewController.initialize(selectedCategory: selectedCategory,
                                                         didSelectCategory: didSelectCategory)
        present(vc, animated: flag, completion: completion)
    }
}
