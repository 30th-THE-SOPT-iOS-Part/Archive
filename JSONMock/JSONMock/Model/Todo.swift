//
//  Todo.swift
//  JSONMock
//
//  Created by taehy.k on 2022/05/27.
//

import Foundation

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
