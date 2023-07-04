//
//  RoundCornerMarkBehavior.swift
//  TodoApp
//
//  Created by Heligate on 29/06/2023.
//

import UIKit

class RoundCornerMarkViewBehavior: UIControl {
    @IBInspectable var topLeftRadius: Bool = false
    @IBInspectable var topRightRadius: Bool = false
    @IBInspectable var bottomLeftRadius: Bool = false
    @IBInspectable var bottomRightRadius: Bool = false
    @IBInspectable var radius: CGFloat = 0

    @IBOutlet var views: [UIView]? {
        didSet {
            configSubView()
        }
    }

    private func configSubView() {
        if radius > 0 && (topLeftRadius || topRightRadius || bottomLeftRadius || bottomRightRadius) {
            views?.forEach { $0.roundCornerMasks(topLeftRadius: self.topLeftRadius,
                                                 topRightRadius: self.topRightRadius,
                                                 bottomLeftRadius: self.bottomLeftRadius,
                                                 bottomRightRadius: self.bottomRightRadius,
                                                 radius: self.radius) }
        }
    }
}

// MARK: - Coner radius

extension UIView {
    func roundCornerMasks(topLeftRadius: Bool = false,
                          topRightRadius: Bool = false,
                          bottomLeftRadius: Bool = false,
                          bottomRightRadius: Bool = false,
                          radius: CGFloat)
    {
        var maskedCorners: CACornerMask {
            //    CACornerMask              Corner
            //    layerMinXMinYCorner       top left corner
            //    layerMaxXMinYCorner       top right corner
            //    layerMinXMaxYCorner       bottom left corner
            //    layerMaxXMaxYCorner       bottom right corner
            let rawOptionSet = [topLeftRadius ? CACornerMask.layerMinXMinYCorner.rawValue : 0,
                                topRightRadius ? CACornerMask.layerMaxXMinYCorner.rawValue : 0,
                                bottomLeftRadius ? CACornerMask.layerMinXMaxYCorner.rawValue : 0,
                                bottomRightRadius ? CACornerMask.layerMaxXMaxYCorner.rawValue : 0].reduce(0, +)
            return CACornerMask(rawValue: UInt(rawOptionSet))
        }

        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
        clipsToBounds = true
    }
}
