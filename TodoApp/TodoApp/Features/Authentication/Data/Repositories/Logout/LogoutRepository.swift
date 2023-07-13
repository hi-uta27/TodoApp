//
//  LogoutRepository.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol LogoutRepository {
    func logout(completed: @escaping (Error?) -> Void)
}
