//
//  UserInfoRemoteDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol UserInfoRemoteDataSource {
    func readUserInfo(completed: @escaping (UserDTO?) -> Void)
}
