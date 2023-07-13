//
//  UserInforUseCase.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol UserInforUseCase {
    func readUserInfor(completed: @escaping (UserEntity?) -> Void)
}
