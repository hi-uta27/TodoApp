//
//  OnboardingCell.swift
//  TodoApp
//
//  Created by TaHieu on 7/10/23.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    static let identifier = "OnboardingCell"

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var image: UIImageView!
    @IBOutlet private var pageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension OnboardingCell {
    func binding(_ model: OnboardingModel, indexPath: IndexPath) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        image.image = UIImage(named: "\(model.image)")
        pageControl.currentPage = indexPath.row
    }
}
