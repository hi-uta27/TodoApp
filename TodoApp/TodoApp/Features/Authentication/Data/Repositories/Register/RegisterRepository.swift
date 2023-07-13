//
//  RegisterRepository.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol RegisterRepository {
    func registerWith(email: String, password: String, confirmPassword: String, completed: @escaping (Result<UserEntity, Error>) -> Void)
}
