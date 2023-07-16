//
//  ChangePasswordRepositories.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation

protocol ChangePasswordRepositories {
    func changePassword(_ password: String, oldPassword: String, completed: @escaping (Error?) -> Void)
}
