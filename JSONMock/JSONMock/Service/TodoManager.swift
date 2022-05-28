//
//  TodoManager.swift
//  JSONMock
//
//  Created by taehy.k on 2022/05/27.
//

import Foundation

final class TodoManager {
    // service code
    static let shared = TodoManager()
    private init() {}
}

extension TodoManager {
    func getTodoMock() -> [Todo] {
        return MockParser.load([Todo].self, from: "Todo")!
    }
}
