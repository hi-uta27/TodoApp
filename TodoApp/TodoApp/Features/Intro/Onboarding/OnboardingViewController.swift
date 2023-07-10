//
//  OnboardingViewController.swift
//  TodoApp
//
//  Created by TaHieu on 7/9/23.
//

import UIKit

class OnboardingViewController: BaseViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var confirmLabel: UILabel!

    private lazy var onboardingTableViewDataSource = OnboardingCollectionDataSource()
    private var tapInsideSkipButton: (() -> Void)!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configSubView() {
        super.configSubView()
        onboardingTableViewDataSource.configCollectionView(collectionView)
        onboardingTableViewDataSource.scrollToEnd = { [weak self] result in
            self?.confirmLabel.text = result ? "GET STARTED" : "NEXT"
            guard result == true else { return }
            self?.tapInsideSkipButton?()
        }
    }

    @IBAction private func touchUpInsideSkipButton(_ sender: Any) {
        tapInsideSkipButton?()
    }

    @IBAction private func touchUpInsideBackButton(_ sender: Any) {
        onboardingTableViewDataSource.moveToPreviousItem()
    }

    @IBAction private func touchUpInsideNextButton(_ sender: Any) {
        onboardingTableViewDataSource.moveToNextItem()
    }
}

extension OnboardingViewController {
    static func initial(tapInsideSkipButton: @escaping () -> Void) -> Self {
        let viewController = initial()
        viewController.tapInsideSkipButton = tapInsideSkipButton
        return viewController
    }
}
