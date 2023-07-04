//
//  BorderViewBehavior.swift
//  TodoApp
//
//  Created by Heligate on 29/06/2023.
//

import UIKit

class BorderViewBehavior: UIControl {
    @IBInspectable var color: UIColor?
    @IBInspectable var width: CGFloat = 0

    @IBOutlet var views: [UIView]? {
        didSet {
            configSubView()
        }
    }

    private func configSubView() {
        if let color = color, width > 0 {
            views?.forEach { $0.border(width: self.width, color: color) }
        }
    }
}

// MARK: - Border

extension UIView {
    func border(width: CGFloat = 1, color: UIColor = .lightGray) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
