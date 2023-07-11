//
//  OnboardingModel.swift
//  TodoApp
//
//  Created by TaHieu on 7/10/23.
//

import Foundation

struct OnboardingModel {
    let title: String
    let description: String
    let image: String
}

extension OnboardingModel {
    static let onboardings = [
        OnboardingModel(title: "Manage your tasks", description: "You can easily manage all of your daily tasks in DoMe for free", image: "Onboarding1"),
        OnboardingModel(title: "Create daily routine", description: "In Uptodo  you can create your personalized routine to stay productive", image: "Onboarding2"),
        OnboardingModel(title: "Orgonaize your tasks", description: "You can organize your daily tasks by adding your tasks into separate categories", image: "Onboarding3")
    ]
}
