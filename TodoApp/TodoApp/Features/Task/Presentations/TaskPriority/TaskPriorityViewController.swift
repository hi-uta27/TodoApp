//
//  TaskPriorityViewController.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import UIKit

class TaskPriorityViewController: BaseViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var cancelButton: UIButton!
    @IBOutlet private var saveButton: UIButton!
    @IBOutlet private var backgroundContentView: UIView!

    private lazy var collectionViewDataSource = TaskPriorityCollectionViewDataSource()
    private var selectedPriority: Int?
    private var didSelectPriority: ((Int) -> Void)!
    private let priorities = Int.taskPriorities

    override func configSubView() {
        print(Self.self, #function)
        backgroundContentView.roundCorners(with: 4)
        saveButton.roundCorners(with: 4)
        configCollectionView()
    }

    private func configCollectionView() {
        collectionViewDataSource.configCollectionView(collectionView)
        collectionViewDataSource.didSelectItemAt = { [weak self] priority in
            self?.setSelectedPriority(priority)
        }
        collectionViewDataSource.setData(priorities)
        collectionViewDataSource.setSelectedPriority(selectedPriority)
    }

    private func setSelectedPriority(_ priority: Int) {
        selectedPriority = priority
        collectionViewDataSource.setSelectedPriority(priority)
    }

    override func shoudClose() -> Bool {
        navigationController?.popSlideDown()
        return false
    }

    @IBAction private func touchUpInsideSaveButton(_ sender: Any) {
        print(Self.self, #function)
        guard let selectedPriority = selectedPriority else { return }
        didSelectPriority?(selectedPriority)
    }
}

extension TaskPriorityViewController {
    static func initialize(selectedPriority: Int?, didSelectPriority: @escaping (Int) -> Void) -> Self {
        let viewController = initial()
        viewController.selectedPriority = selectedPriority
        viewController.didSelectPriority = didSelectPriority
        return viewController
    }
}

extension UIViewController {
    func presentTaskPriority(selectedPriority: Int?, didSelectPriority: @escaping (Int) -> Void, completion: (() -> Void)?) {
        let vc = TaskPriorityViewController.initialize(selectedPriority: selectedPriority, didSelectPriority: didSelectPriority)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: completion)
    }
}
