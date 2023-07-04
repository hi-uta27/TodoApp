//
//  Entity.swift
//  TodoApp
//
//  Created by Heligate on 07/06/2023.
//

import Foundation

protocol CategoryEntity {
    var id: String { get }
    var name: String { get }
    var icon: String { get }
    var color: String { get }
}
