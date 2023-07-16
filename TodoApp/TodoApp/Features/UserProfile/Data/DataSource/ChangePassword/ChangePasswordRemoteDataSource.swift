//
//  ChangePasswordRemoteDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation

protocol ChangePasswordRemoteDataSource {
    func changePassword(_ password: String, oldPassword: String, completed: @escaping (Error?) -> Void)
}
