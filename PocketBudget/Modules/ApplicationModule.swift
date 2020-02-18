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
    case navigation(title: String)
}

//
// MARK: APPLICATION MODULES
//
enum ApplicationModule {
    case accountsEditor(input: AccountsEditorModuleInput)
    case accountSettings(input: AccountSettingsModuleInput)
    case expensesEditor(input: ExpensesEditorModuleInput)
    case newExpenseEditor(input: NewExpenseEditorModuleInput)

    func build() -> UIViewController? {
        guard let controller = buildController() else {
            return nil
        }
        switch embeddingType {
        case .none:
            return controller
        case .navigation(let title):
            let navigationController = UINavigationController(rootViewController: controller)
            controller.navigationItem.title = title
            return navigationController
        }
    }
}

extension ApplicationModule {
    var embeddingType: EmbeddingType {
        switch self {
        case .accountsEditor:
            return .navigation(title: "accounts_editor_title".localized)
        case .accountSettings, .expensesEditor, .newExpenseEditor:
            return .none
        }
    }
}

extension ApplicationModule {
    private func buildController() -> UIViewController? {
        switch self {
        case .accountsEditor(let input):
            return assembleAccountsEditor(with: input)
        case .accountSettings(let input):
            return assembleAccountSettings(with: input)
        case .expensesEditor(let input):
            return assembleExpensesEditor(with: input)
        case .newExpenseEditor(let input):
            return assembleNewExpenseEditor(with: input)
        }
    }
}
