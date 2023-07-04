//
//  TabbarButton.swift
//  TodoApp
//
//  Created by Heligate on 29/06/2023.
//

import UIKit

class TabbarButton: UIButton {
    @IBOutlet var components: [UIButton]!

    override var isSelected: Bool {
        get {
            super.isSelected
        }
        set {
            components.forEach { $0.isSelected = newValue }
            super.isSelected = newValue
        }
    }

    override var isHighlighted: Bool {
        get {
            super.isHighlighted
        }
        set {
            components.forEach { $0.isHighlighted = newValue }
            super.isHighlighted = newValue
        }
    }
}
