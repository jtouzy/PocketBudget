//
//  ApplicationWireframe+ExpensesEditor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION MODULE EXTENSION FOR EXPENSES-EDITOR MODULE
//
extension ApplicationModule {
    func assembleExpensesEditor(for accountId: String, of type: ExpenseType) -> ExpensesEditorViewController? {
        guard let view: ExpensesEditorViewController = UIViewController.load() else {
            return nil
        }
        view.presenter = ExpensesEditorPresenterImpl(view: view, for: accountId, of: type)
        return view
    }
}
