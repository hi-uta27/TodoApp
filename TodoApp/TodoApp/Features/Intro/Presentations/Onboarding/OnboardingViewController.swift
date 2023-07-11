//
//  OnboardingViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/9/23.
//

import UIKit

class OnboardingViewController: BaseViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var nextLabel: UILabel!
    @IBOutlet private var pageControl: UIPageControl!

    private lazy var onboardingTableViewDataSource = OnboardingCollectionDataSource()
    private var openGetStarted: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configSubView() {
        super.configSubView()
        onboardingTableViewDataSource.configCollectionView(collectionView)
        onboardingTableViewDataSource.scrollToEndOfItem = { [weak self] result in
            self?.scrollToEndOfItem(isScrollToEnd: result)
        }
        let models = OnboardingModel.onboardings
        pageControl.numberOfPages = models.count
        onboardingTableViewDataSource.setData(models)
    }

    private func scrollToEndOfItem(isScrollToEnd: Bool) {
        nextLabel.text = isScrollToEnd ? "GET STARTED" : "NEXT"
        pageControl.currentPage = onboardingTableViewDataSource.selectedPage
    }

    @IBAction private func touchUpInsideSkipButton(_ sender: Any) {
        openGetStarted?()
    }

    @IBAction private func touchUpInsideBackButton(_ sender: Any) {
        onboardingTableViewDataSource.moveToPreviousItem()
    }

    @IBAction private func touchUpInsideNextButton(_ sender: Any) {
        if onboardingTableViewDataSource.selectedPage == pageControl.numberOfPages - 1 {
            openGetStarted?()
        } else {
            onboardingTableViewDataSource.moveToNextItem()
        }
    }
}

extension OnboardingViewController {
    static func initial(openGetStarted: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.openGetStarted = openGetStarted
        return viewController
    }
}
