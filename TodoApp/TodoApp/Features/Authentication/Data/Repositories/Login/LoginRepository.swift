//
//  .swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol LoginRepository {
    func loginWith(email: String, password: String, completed: @escaping (Result<UserEntity, Error>) -> Void)
    func loginWithGoogle(completed: @escaping (Result<UserEntity, Error>) -> Void)
}
