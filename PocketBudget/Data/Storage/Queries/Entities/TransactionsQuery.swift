//
//  TransactionsQuery.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import ExtendedFoundations

class TransactionsQuery: Query<Transaction> {
    let id: String?
    let monthId: String?
    let expenseId: String?

    init(id: String? = nil, monthId: String? = nil, expenseId: String? = nil) {
        self.id = id
        self.monthId = monthId
        self.expenseId = expenseId
        super.init()
    }
}
