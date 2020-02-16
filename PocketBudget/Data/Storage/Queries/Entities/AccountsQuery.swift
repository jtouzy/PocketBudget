//
//  AccountsQuery.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class AccountsQuery: Query<Account> {
    let id: String?

    init(id: String? = nil) {
        self.id = id
    }

    override func filter(from items: [Account]) -> [Account] {
        return items.filter { [weak self] item in
            guard let self = self else { return false }
            var filterCondition = true
            if let id = self.id {
                filterCondition = filterCondition && item.id == id
            }
            return filterCondition
        }
    }
}
