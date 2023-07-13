//
//  UserDTO.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Firebase
import Foundation

typealias UserDTO = User

extension User {
    func transferToModel() -> UserEntity {
        return UserInfoModel(uid: uid, email: email ?? "", displayName: displayName ?? "", image: nil)
    }
}
