//
//  CategoryColorCell.swift
//  TodoApp
//
//  Created by Heligate on 12/06/2023.
//

import UIKit

class CategoryColorCell: UICollectionViewCell {
    static let identifier = "CategoryColorCell"
    @IBOutlet private var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let radius: CGFloat = button.bounds.size.width * 0.5
        button.roundCorners(with: radius)
    }
}

extension CategoryColorCell {
    func binding(color: String) {
        button.backgroundColor = UIColor(hex: color)
    }

    func selected(_ isSelected: Bool) {
        button.isSelected = isSelected
    }
}
