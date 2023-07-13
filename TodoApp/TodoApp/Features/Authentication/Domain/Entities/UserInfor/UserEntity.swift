//
//  UserEntity.swift
//  TodoApp
//
//  Created by TaHieu on 7/13/23.
//

import Foundation

protocol UserEntity {
    var uid: String { get }
    var email: String { get }
    var displayName: String { get }
    var image: URL { get }
}
