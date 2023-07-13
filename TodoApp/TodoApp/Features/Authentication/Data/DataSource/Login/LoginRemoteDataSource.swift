//
//  LoginRemoteDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol LoginRemoteDataSource {
    func loginWith(email: String, password: String, completed: @escaping (Result<UserDTO, Error>) -> Void)
    func loginWithGoogle(completed: @escaping (Result<UserDTO, Error>) -> Void)
}
