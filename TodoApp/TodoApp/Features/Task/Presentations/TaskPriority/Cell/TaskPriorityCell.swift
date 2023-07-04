//
//  TaskPriorityCell.swift
//  TodoApp
//
//  Created by Heligate on 15/06/2023.
//

import UIKit

class TaskPriorityCell: UICollectionViewCell {
    static let identifier = "TaskPriorityCell"
    @IBOutlet private var backgroundStackView: UIStackView!
    @IBOutlet private var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundStackView.roundCorners(with: 4)
    }
}

extension TaskPriorityCell {
    func binding(priority: Int) {
        label.text = "\(priority)"
    }

    func selected(_ isSelected: Bool) {
        backgroundStackView.backgroundColor = isSelected ? UIColor(named: "8687E7") : UIColor(named: "272727")
    }
}
