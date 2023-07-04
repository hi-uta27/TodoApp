//
//  KeyboardNotifications.swift
//  TodoApp
//
//  Created by Heligate on 16/06/2023.
//

import UIKit

@objc protocol KeyboardNotifications {
    func keyboardWillHideNotification(_ notification: Notification)
    func keyboardWillShowNotification(_ notification: Notification)
}

extension KeyboardNotifications {
    func addObserveKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
