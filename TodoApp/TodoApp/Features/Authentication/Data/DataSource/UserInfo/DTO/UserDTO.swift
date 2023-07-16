//
//  UserDTO.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import FirebaseAuth
import Foundation

typealias UserDTO = User

extension User {
    func transferToModel() -> UserEntity {
        return UserInfoModel(
            uid: uid,
            email: email ?? "Invalid Email",
            displayName: displayName ?? email ?? "Invalid Name",
            image: photoURL)
    }
}
