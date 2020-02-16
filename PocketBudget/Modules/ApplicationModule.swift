//
//  ApplicationModule.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: MODULE EMBEDDING TYPE
//
enum EmbeddingType {
    case none
    case navigation
}

//
// MARK: APPLICATION MODULES
//
enum ApplicationModule {
    case accountSettings(accountId: String)
    case newExpenseEditor(accountId: String)
    case requiredExpensesEditor(accountId: String)

    var embeddingType: EmbeddingType {
        switch self {
        case .accountSettings:
            return .navigation
        case .newExpenseEditor, .requiredExpensesEditor:
            return .none
        }
    }

    func build() -> UIViewController? {
        guard let controller = buildController() else {
            return nil
        }
        switch embeddingType {
        case .none:
            return controller
        case .navigation:
            return UINavigationController(rootViewController: controller)
        }
    }

    private func buildController() -> UIViewController? {
        switch self {
        case .accountSettings(let accountId):
            return assembleAccountSettings(for: accountId)
        case .newExpenseEditor(let accountId):
            return assembleNewExpenseEditor(for: accountId)
        case .requiredExpensesEditor(let accountId):
            return assembleRequiredExpensesEditor(for: accountId)
        }
    }
}
