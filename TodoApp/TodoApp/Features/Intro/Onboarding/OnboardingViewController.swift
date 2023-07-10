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

    private lazy var onboardingTableViewDataSource = OnboardingCollectionDataSource()
    private var openGetStarted: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configSubView() {
        super.configSubView()
        onboardingTableViewDataSource.configCollectionView(collectionView)
        onboardingTableViewDataSource.scrollToEnd = { [weak self] result in
            DispatchQueue.main.async {
                self?.nextLabel.text = result ? "GET STARTED" : "NEXT"
                guard result == true else { return }
                self?.openGetStarted?()
            }
        }
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
