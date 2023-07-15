//
//  RegisterUseCase.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol RegisterUseCase {
    func registerWith(email: String, password: String, completed: @escaping (Result<UserEntity, Error>) -> Void)
}
