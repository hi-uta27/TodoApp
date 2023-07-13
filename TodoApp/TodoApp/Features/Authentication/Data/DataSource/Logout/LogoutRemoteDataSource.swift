//
//  LogoutRemoteDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol LogoutRemoteDataSource {
    func logout(completed: @escaping (Error?) -> Void)
}
