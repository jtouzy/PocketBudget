//
//  ApplicationModule+AccountSettings.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION MODULE EXTENSION FOR ACCOUNT-SETTINGS MODULE
//
extension ApplicationModule {
    func assembleAccountSettings(for accountId: String) -> AccountSettingsViewController? {
        guard let view: AccountSettingsViewController = UIViewController.load() else {
            return nil
        }
        view.presenter = AccountSettingsPresenterImpl(view: view, for: accountId)
        return view
    }
}
