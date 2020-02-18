//
//  ApplicationModule+AccountsEditor.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION MODULE EXTENSION FOR ACCOUNTS-EDITOR MODULE
//
extension ApplicationModule {
    func assembleAccountsEditor(with input: AccountsEditorModuleInput) -> AccountsEditorViewController? {
        guard let view: AccountsEditorViewController = UIViewController.load() else {
            return nil
        }
        view.presenter = AccountsEditorPresenterImpl(view: view, with: input)
        return view
    }
}
