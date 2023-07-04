//
//  TaskPriorityCollectionViewDataSource.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import UIKit

class TaskPriorityCollectionViewDataSource: NSObject {
    private weak var collectionView: UICollectionView?
    private var priorities: [Int] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    let numberOfRow: CGFloat = 4
    let minimumLineSpacing: CGFloat = 16
    let minimumInteritemSpacing: CGFloat = 16
    var didSelectItemAt: ((Int) -> Void)?
    private var selectedPriority: Int? {
        didSet {
            collectionView?.reloadData()
        }
    }

    func configCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(.init(nibName: TaskPriorityCell.identifier, bundle: nil), forCellWithReuseIdentifier: TaskPriorityCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
    }

    func setData(_ priorities: [Int]) {
        self.priorities = priorities
    }

    func setSelectedPriority(_ selectedPriority: Int?) {
        self.selectedPriority = selectedPriority
    }
}

// MARK: - UICollectionViewDataSource

extension TaskPriorityCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        priorities.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskPriorityCell.identifier, for: indexPath) as! TaskPriorityCell
        let priority = priorities[indexPath.row]
        cell.binding(priority: priority)
        cell.selected(priority == selectedPriority)

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TaskPriorityCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(Self.self, #function)
        didSelectItemAt?(priorities[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TaskPriorityCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = CGFloat(numberOfRow - 1) * minimumLineSpacing
        let widthCell = (collectionView.visibleSize.width - spacing) / numberOfRow
        let heightCell = widthCell
        return CGSize(width: widthCell, height: heightCell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        minimumInteritemSpacing
    }
}
