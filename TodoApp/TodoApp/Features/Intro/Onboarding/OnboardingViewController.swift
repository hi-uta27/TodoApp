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
        onboardingTableViewDataSource.scrollToEnd = { [weak self] result in
            self?.scrollToEnd(isScrollToEnd: result)
        }
        let models = OnboardingModel.onboardings
        pageControl.numberOfPages = models.count
        onboardingTableViewDataSource.setData(models)
    }

    private func scrollToEnd(isScrollToEnd: Bool) {
        nextLabel.text = isScrollToEnd ? "GET STARTED" : "NEXT"
        pageControl.currentPage = onboardingTableViewDataSource.selectedPage
        guard isScrollToEnd == true else { return }
        openGetStarted?()
    }

    @IBAction private func touchUpInsideSkipButton(_ sender: Any) {
        openGetStarted?()
    }

    @IBAction private func touchUpInsideBackButton(_ sender: Any) {
        onboardingTableViewDataSource.moveToPreviousItem()
    }

    @IBAction private func touchUpInsideNextButton(_ sender: Any) {
        onboardingTableViewDataSource.moveToNextItem()
    }
}

extension OnboardingViewController {
    static func initial(openGetStarted: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.openGetStarted = openGetStarted
        return viewController
    }
}
