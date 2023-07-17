//
//  ChangeAccountImageUseCase.swift
//  TodoApp
//
//  Created by TaHieu on 7/17/23.
//

import Foundation

protocol ChangeAccountImageUseCase {
    func changeImage(_ image: Data, completed: @escaping (Result<URL, Error>) -> Void)
}
