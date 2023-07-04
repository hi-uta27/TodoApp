//
//  TimePickerView.swift
//  TodoApp
//
//  Created by Heligate on 21/06/2023.
//

import UIKit

class TimePickerCell: UIView {
    static let identifier = "TimePickerCell"
    @IBOutlet private var titleLabel: UILabel!

    func binding(_ title: String) {
        titleLabel.text = title
    }
}

extension TimePickerCell {
    static func initial() -> Self {
        return Bundle.main.loadNibNamed(identifier, owner: nil)?.first as! Self
    }
}
