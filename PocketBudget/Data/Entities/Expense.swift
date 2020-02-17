//
//  Expense.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class Expense: Codable, Equatable, Identifiable {
    let id: String
    let title: String
    let color: Color
    let accountId: String

    init(id: String, title: String, color: Color, accountId: String) {
        self.id = id
        self.title = title
        self.color = color
        self.accountId = accountId
    }

    static func == (first: Expense, second: Expense) -> Bool {
        return first.id == second.id
    }
}
