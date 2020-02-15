//
//  ApplicationModule+NewExpenseEditor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION MODULE EXTENSION FOR NEW-EXPENSE-EDITOR MODULE
//
extension ApplicationModule {
    func assembleNewExpenseEditor() -> NewExpenseEditorViewController? {
        guard let view: NewExpenseEditorViewController = UIViewController.load() else {
            return nil
        }
        view.presenter = NewExpenseEditorPresenterImpl(view: view)
        return view
    }
}
