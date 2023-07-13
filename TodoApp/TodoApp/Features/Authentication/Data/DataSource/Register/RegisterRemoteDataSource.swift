//
//  RegisterRemoteDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol RegisterRemoteDataSource {
    func registerWith(email: String, password: String, confirmPassword: String, completed: @escaping (Result<UserDTO, Error>) -> Void)
}
