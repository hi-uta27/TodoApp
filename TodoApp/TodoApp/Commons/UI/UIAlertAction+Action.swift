//
//  UIAlertAction+Action.swift
//  TodoApp
//
//  Created by Heligate on 13/06/2023.
//

import UIKit

extension UIAlertAction {
    static func cancelAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        UIAlertAction(title: "Cancel", style: .destructive, handler: handler)
    }

    static func okAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        UIAlertAction(title: "Ok", style: .default, handler: handler)
    }

    static func tryAgainAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        UIAlertAction(title: "Try Again", style: .default, handler: handler)
    }
}
