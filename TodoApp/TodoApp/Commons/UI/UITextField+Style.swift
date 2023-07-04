//
//  UITextField+Style.swift
//  TodoApp
//
//  Created by Heligate on 12/06/2023.
//

import UIKit

extension UITextField {
    @IBInspectable var placeholderColor: UIColor? {
        set {
            guard let placeholder = placeholder, let color = newValue else { return }
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: color]
            )
        }
        get {
            return nil
        }
    }
}
