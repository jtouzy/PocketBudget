//
//  ApplicationModule+MonthBalance.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: APPLICATION MODULE EXTENSION FOR MONTH-BALANCE MODULE
//
extension ApplicationModule {
    func assembleMonthBalance(with input: MonthBalanceModuleInput) -> MonthBalanceViewController? {
        guard let view: MonthBalanceViewController = UIViewController.load() else {
            return nil
        }
        view.presenter = MonthBalancePresenterImpl(view: view, with: input)
        return view
    }
}
