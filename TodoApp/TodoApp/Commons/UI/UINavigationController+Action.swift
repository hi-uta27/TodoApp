//
//  UINavigationController+Action.swift
//  TodoApp
//
//  Created by Heligate on 22/06/2023.
//

import UIKit

extension UINavigationController {
    func pushSlideUpViewController(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.24
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        view.layer.add(transition, forKey: kCATransition)
        pushViewController(viewController, animated: false)
    }

    func popSlideDown() {
        let transition = CATransition()
        transition.duration = 0.24
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
    }

    func popSlideDownToRoot() {
        let transition = CATransition()
        transition.duration = 0.24
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.layer.add(transition, forKey: kCATransition)
        popToRootViewController(animated: false)
    }
}
