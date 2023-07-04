//
//  CategoryCollectionViewDataSource.swift
//  TodoApp
//
//  Created by Heligate on 09/06/2023.
//

import UIKit

class CategoryCollectionViewDataSource: NSObject {
    private weak var collectionView: UICollectionView?
    private var models: [CategoryEntity] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    let numberOfRow: CGFloat = 3
    let minimumLineSpacing: CGFloat = 16
    let minimumInteritemSpacing: CGFloat = 16
    var didSelectItemAt: ((CategoryEntity) -> Void)?

    var selectedCategory: CategoryEntity? {
        didSet {
            collectionView?.reloadData()
        }
    }

    func configCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(.init(nibName: CategoryCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
    }

    func setModels(_ models: [CategoryEntity]) {
        self.models = models
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        let model = models[indexPath.row]
        cell.binding(model: model)
        if let selectedEntity = selectedCategory {
            cell.highlight(isHighlight: selectedEntity.id == model.id)
        } else {
            cell.highlight(isHighlight: false)
        }
        return cell
    }
}

extension CategoryCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        didSelectItemAt?(models[row])
    }
}

extension CategoryCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
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
