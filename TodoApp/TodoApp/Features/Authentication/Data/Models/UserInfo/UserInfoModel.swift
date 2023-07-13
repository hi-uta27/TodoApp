//
//  UserInfoModel.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

struct UserInfoModel: UserEntity {
    let uid: String
    let email: String
    let displayName: String
    let image: URL
}
