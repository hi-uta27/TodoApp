//
//  UIStackView+Style.swift
//  TodoApp
//
//  Created by Heligate on 14/06/2023.
//
import UIKit

extension UIStackView {
    func setBorder(borderWidth: Int = 0,
                   borderColor: UIColor? = nil,
                   radius: CGFloat = 0,
                   contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    {
        roundCorners(with: radius)
        border(color: borderColor ?? .clear)
        layoutMargins = contentInset
        isLayoutMarginsRelativeArrangement = true
    }
}
