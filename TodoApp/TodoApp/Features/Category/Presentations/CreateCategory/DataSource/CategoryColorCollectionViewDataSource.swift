//
//  CategoryColorCollectionViewDataSource.swift
//  TodoApp
//
//  Created by Heligate on 12/06/2023.
//

import UIKit

class CategoryColorCollectionViewDataSource: NSObject {
    private weak var collectionView: UICollectionView?
    private var colors: [String] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }

    let minimumLineSpacing: CGFloat = 12
    var didSelectItemAt: ((String) -> Void)?
    private var selectedColor: String? {
        didSet {
            collectionView?.reloadData()
        }
    }

    func configCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(.init(nibName: CategoryColorCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryColorCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
    }

    func setData(_ colors: [String]) {
        self.colors = colors
    }

    func setSelectedColor(_ selectedColor: String?) {
        self.selectedColor = selectedColor
    }
}

// MARK: - UICollectionViewDataSource

extension CategoryColorCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryColorCell.identifier, for: indexPath) as! CategoryColorCell
        let color = colors[indexPath.row]
        cell.binding(color: color)
        cell.selected(selectedColor == color)

        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension CategoryColorCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(Self.self, #function)
        didSelectItemAt?(colors[indexPath.row])
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryColorCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 36, height: 36)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
}
