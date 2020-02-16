//
//  ExpensesQuery.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class ExpensesQuery: Query<Expense> {
    let id: String?
    let accountId: String?

    init(id: String? = nil, accountId: String? = nil) {
        self.id = id
        self.accountId = accountId
    }

    override func filter(from items: [Expense]) -> [Expense] {
        return items.filter { [weak self] item in
            guard let self = self else { return false }
            var filterCondition = true
            if let id = self.id {
                filterCondition = filterCondition && item.id == id
            }
            if let accountId = self.accountId, filterCondition == true {
                filterCondition = filterCondition && item.accountId == accountId
            }
            return filterCondition
        }
    }
}
