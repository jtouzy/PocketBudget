//
//  AccountSettingsModels.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

enum AccountSettingsItem {
    case fixedIncomes
    case optionalIncomes
    case requiredExpenses
    case optionalExpenses

    var title: String {
        switch self {
        case .fixedIncomes:
            return "account_settings_fixed_incomes_title".localized
        case .optionalIncomes:
            return "account_settings_optional_incomes_title".localized
        case .requiredExpenses:
            return "account_settings_required_expenses_title".localized
        case .optionalExpenses:
            return "account_settings_optional_expenses_title".localized
        }
    }

    var subtitle: String? {
        switch self {
        case .fixedIncomes:
            return "account_settings_fixed_incomes_description".localized
        case .optionalIncomes:
            return "account_settings_optional_incomes_description".localized
        case .requiredExpenses:
            return "account_settings_required_expenses_description".localized
        case .optionalExpenses:
            return "account_settings_optional_expenses_description".localized
        }
    }

    var systemImageName: String {
        switch self {
        case .optionalIncomes, .fixedIncomes:
            return "plus.square"
        case .optionalExpenses, .requiredExpenses:
            return "minus.square"
        }
    }

    var systemImageColor: UIColor {
        switch self {
        case .optionalIncomes, .fixedIncomes:
            return .materialGreen
        case .optionalExpenses, .requiredExpenses:
            return .materialRed
        }
    }
}
