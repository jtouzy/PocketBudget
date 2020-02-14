//
//  ApplicationWireframe+RequiredExpensesEditor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION MODULE EXTENSION FOR REQUIRED-EXPENSES-EDITOR MODULE
//
extension ApplicationModule {
    func assembleRequiredExpensesEditor() -> RequiredExpensesEditorViewController? {
        guard let view: RequiredExpensesEditorViewController = UIViewController.load() else {
            return nil
        }
        view.presenter = RequiredExpensesEditorPresenterImpl(view: view)
        return view
    }
}
