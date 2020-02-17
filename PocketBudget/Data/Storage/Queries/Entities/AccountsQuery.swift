//
//  AccountsQuery.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import ExtendedFoundations

class AccountsQuery: Query<Account> {
    let id: String?

    init(id: String? = nil) {
        self.id = id
        super.init()
    }
}
