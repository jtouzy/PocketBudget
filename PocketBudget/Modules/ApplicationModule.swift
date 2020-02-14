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
    case requiredExpensesEditor

    func build() -> UIViewController? {
        switch self {
        case .requiredExpensesEditor:
            return assembleRequiredExpensesEditor()
        }
    }
}
