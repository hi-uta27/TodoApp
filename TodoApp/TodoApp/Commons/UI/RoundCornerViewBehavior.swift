//
//  RoundCornerBehavior.swift
//  TodoApp
//
//  Created by Heligate on 29/06/2023.
//

import UIKit

class RoundCornerViewBehavior: UIControl {
    @IBInspectable var radius: CGFloat = 0

    @IBOutlet var views: [UIView]? {
        didSet {
            configSubView()
        }
    }

    private func configSubView() {
        if radius > 0 {
            views?.forEach { $0.roundCorners(with: self.radius) }
        }
    }
}

// MARK: - Coner radius

extension UIView {
    func roundCorners(with radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}
