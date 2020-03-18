//
//  ApplicationModule+AccountCreationWizard.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION MODULE EXTENSION FOR ACCOUNT CREATION WIZARD MODULE
//
extension ApplicationModule {
    func assembleAccountCreationWizard(with input: AccountCreationWizardModuleInput) -> ACWAccountTitleViewController? {
        guard let view: ACWAccountTitleViewController = UIViewController.load() else {
            return nil
        }
        view.presenter = AccountCreationWizardPresenterImpl(view: view, with: input)
        return view
    }
}
