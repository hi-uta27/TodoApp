//
//  Array+UIButton.swift
//  TodoApp
//
//  Created by Heligate on 30/06/2023.
//

import UIKit

extension Array where Element: UIButton {
    var selectedIndex: Int? {
        get {
            firstIndex(where: { $0.isSelected })
        }
        set {
            if let index = newValue {
                let newIndex: Int = Swift.max(Swift.min(count, index), 0)
                for i in 0 ..< count {
                    self[i].isSelected = i == newIndex
                }
            } else {
                forEach { $0.isSelected = false }
            }
        }
    }
}
