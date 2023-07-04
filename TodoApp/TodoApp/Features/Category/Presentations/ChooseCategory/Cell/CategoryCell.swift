//
//  CategoryCell.swift
//  TodoApp
//
//  Created by Heligate on 08/06/2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"

    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension CategoryCell {
    func binding(model: CategoryEntity) {
        button.roundCorners(with: 4)
        button.backgroundColor = UIColor(hex: model.color)
        button.setImage(UIImage(named: model.icon), for: .normal)
        label.text = model.name
    }
    
    func highlight(isHighlight: Bool) {
        label.textColor = isHighlight ? .orange : .white
    }
}
