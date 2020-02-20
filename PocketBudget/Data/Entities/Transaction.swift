//
//  Transaction.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class Transaction: Codable {
    let id: String
    let monthId: String
    let expenseId: String
    let amount: Double

    init(id: String, monthId: String, expenseId: String, amount: Double) {
        self.id = id
        self.monthId = monthId
        self.expenseId = expenseId
        self.amount = amount
    }
}
