//
//  ChangeAccountImageRemoteDataSource.swift
//  TodoApp
//
//  Created by TaHieu on 7/17/23.
//

import Foundation

protocol ChangeAccountImageRemoteDataSource {
    func changeImage(_ image: Data, compledted: @escaping (Result<URL, Error>) -> Void)
}
