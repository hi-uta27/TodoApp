//
//  ChangePasswordUseCase.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation

protocol ChangePasswordUseCase {
    func changePassword(_ password: String, completed: @escaping (Error?) -> Void)
}
