//
//  TextFieldClearButtonColorBehavior.swift
//  TodoApp
//
//  Created by Heligate on 29/06/2023.
//

import UIKit

class TextFieldClearButtonBehavior: UIControl {
    @IBInspectable var color: UIColor?

    @IBOutlet var textFields: [UITextField]? {
        didSet {
            configSubview()
        }
    }

    private func configSubview() {
        guard let color = color else { return }
        textFields?.forEach { $0.clearButtonColor(color) }
    }
}

extension UITextField {
    // https://stackoverflow.com/a/50559038
    func clearButtonColor(_ color: UIColor?) {
        guard let clearButton = value(forKey: "_clearButton") as? UIButton else { return }
        let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        clearButton.setImage(templateImage, for: .normal)
        clearButton.setImage(templateImage, for: .highlighted)
        clearButton.tintColor = color
    }
}
