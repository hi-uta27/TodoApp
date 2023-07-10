//
//  OnboardingTableViewDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/10/23.
//

import UIKit

class OnboardingCollectionDataSource: NSObject {
    private weak var collectionView: UICollectionView?
    private var models: [OnboardingModel] = OnboardingModel.onboardings {
        didSet {
            collectionView?.reloadData()
        }
    }

    private var selectedPage = 0
    var scrollToEnd: ((Bool) -> Void)!

    func configCollectionView(_ collectionView: UICollectionView) {
        collectionView.register(.init(nibName: OnboardingCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.collectionView = collectionView
    }

    func setData(_ models: [OnboardingModel]) {
        self.models = models
    }

    func moveToNextItem() {
        scrollTo(index: selectedPage + 1)
    }

    func moveToPreviousItem() {
        scrollTo(index: selectedPage - 1)
    }

    private func scrollTo(index: Int) {
        selectedPage = max(0, min(index, models.count - 1))
        collectionView?.scrollToItem(at: IndexPath(row: selectedPage, section: 0), at: .centeredHorizontally, animated: true)
        scrollToEnd?(selectedPage == models.count - 1)
    }
}

// MARK: - UICollectionViewDataSource

extension OnboardingCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        cell.binding(models[indexPath.row], indexPath: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingCollectionDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.visibleSize.width, height: collectionView.visibleSize.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // TODO: https://www.youtube.com/watch?v=l_S3JJRYOog
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        selectedPage = page
    }
}
