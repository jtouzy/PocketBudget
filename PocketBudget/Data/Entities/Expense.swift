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
    let type: ExpenseType
    let accountId: String

    private enum CodingKeys: CodingKey {
        case id
        case title
        case color
        case type
        case accountId
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        color = try container.decode(Color.self, forKey: .color)
        let rawType = try container.decode(String.self, forKey: .type)
        type = ExpenseType(rawValue: rawType) ?? .required
        accountId = try container.decode(String.self, forKey: .accountId)
    }

    init(id: String, title: String, color: Color, type: ExpenseType, accountId: String) {
        self.id = id
        self.title = title
        self.color = color
        self.type = type
        self.accountId = accountId
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(color, forKey: .color)
        try container.encode(type.rawValue, forKey: .type)
        try container.encode(accountId, forKey: .accountId)
    }

    static func == (first: Expense, second: Expense) -> Bool {
        return first.id == second.id
    }
}
