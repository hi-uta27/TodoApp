//
//  DefaultCategoryModel.swift
//  TodoApp
//
//  Created by Heligate on 07/06/2023.
//

import Foundation

struct AppCategoryModel: CategoryEntity {
    var id: String
    var name: String
    var icon: String
    var color: String
}

extension AppCategoryModel {
    static let defaultCategories: [Self] = {
        [
            AppCategoryModel(id: "Grocery", name: "Grocery", icon: "GroceryIcon", color: "CCFF80"),
            AppCategoryModel(id: "Work", name: "Work", icon: "WorkIcon", color: "FF9680"),
            AppCategoryModel(id: "Sport", name: "Sport", icon: "SportIcon", color: "80FFFF"),
            AppCategoryModel(id: "Design", name: "Design", icon: "DesignIcon", color: "80FFD9"),
            AppCategoryModel(id: "University", name: "University", icon: "UniversityIcon", color: "809CFF"),
            AppCategoryModel(id: "Social", name: "Social", icon: "SocialIcon", color: "FF80EB"),
            AppCategoryModel(id: "Music", name: "Music", icon: "MusicIcon", color: "FC80FF"),
            AppCategoryModel(id: "Health", name: "Health", icon: "HealthIcon", color: "80FFA3"),
            AppCategoryModel(id: "Movie", name: "Movie", icon: "MovieIcon", color: "80D1FF"),
            AppCategoryModel(id: "Home", name: "Home", icon: "HomeIcon", color: "FFCC80"),
        ]
    }()
}
