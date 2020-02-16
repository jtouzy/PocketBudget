//
//  ApplicationModule.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION MODULES
//
enum ApplicationModule {
    case newExpenseEditor(accountId: String)
    case requiredExpensesEditor(accountId: String)

    func build() -> UIViewController? {
        switch self {
        case .newExpenseEditor(let accountId):
            return assembleNewExpenseEditor(for: accountId)
        case .requiredExpensesEditor(let accountId):
            return assembleRequiredExpensesEditor(for: accountId)
        }
    }
}
