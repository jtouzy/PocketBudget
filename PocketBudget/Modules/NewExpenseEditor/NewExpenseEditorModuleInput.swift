//
//  NewExpenseEditorModuleInput.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 18/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

class NewExpenseEditorModuleInput {
    let accountId: String
    let type: ExpenseType

    init(accountId: String, type: ExpenseType) {
        self.accountId = accountId
        self.type = type
    }
}
