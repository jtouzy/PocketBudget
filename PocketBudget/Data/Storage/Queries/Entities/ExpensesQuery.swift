//
//  ExpensesQuery.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import ExtendedFoundations

class ExpensesQuery: Query<Expense> {
    let id: String?
    let accountId: String?

    init(id: String? = nil, accountId: String? = nil) {
        self.id = id
        self.accountId = accountId
        super.init()
    }
}
