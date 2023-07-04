//
//  TaskCell.swift
//  TodoApp
//
//  Created by Heligate on 26/06/2023.
//

import SwiftDate
import UIKit

class TaskCell: UITableViewCell {
    static let identifier = "TaskCell"
    @IBOutlet private var checkBoxButton: UIButton!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateTimeLabel: UILabel!
    @IBOutlet private var categoryLabel: UILabel!
    @IBOutlet private var categoryIconButton: UIButton!
    @IBOutlet private var priorityLabel: UILabel!
    @IBOutlet private var backgroundContentStackView: UIStackView!
    @IBOutlet private var backgroundCategoryStackView: UIStackView!
    @IBOutlet private var backgroundPriorityStackView: UIStackView!

    var tapInsideCheckBox: (() -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        backgroundContentStackView.roundCorners(with: 4)
        backgroundCategoryStackView.roundCorners(with: 4)
        backgroundPriorityStackView.roundCorners(with: 4)
        backgroundPriorityStackView.border(width: 1, color: UIColor(named: "8687E7") ?? .white)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TaskCell {
    func binding(_ taskEntity: TaskEntity) {
        checkBoxButton.isSelected = taskEntity.status == .completed
        titleLabel.text = taskEntity.title
        let stringFormatTime = "'Today At' HH:mm"
        dateTimeLabel.text = taskEntity.startTime.toFormat(stringFormatTime)
        categoryLabel.text = taskEntity.category.name
        categoryIconButton.setImage(UIImage(named: taskEntity.category.icon), for: .normal)
        backgroundCategoryStackView.backgroundColor = UIColor(hex: taskEntity.category.color)
        priorityLabel.text = "\(taskEntity.priority)"
    }

    @IBAction private func touchUpInsideCheckBoxButton(_ sender: Any) {
        print(Self.self, #function)
        tapInsideCheckBox?()
    }
}
