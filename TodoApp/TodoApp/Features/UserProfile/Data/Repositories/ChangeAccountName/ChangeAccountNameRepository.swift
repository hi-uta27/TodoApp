//
//  ChangeAccountNameRepository.swift
//  TodoApp
//
//  Created by TaHieu on 7/16/23.
//

import Foundation

protocol ChangeAccountNameRepository {
    func changeAccountName(_ name: String, completed: @escaping (Result<String, Error>) -> Void)
}
