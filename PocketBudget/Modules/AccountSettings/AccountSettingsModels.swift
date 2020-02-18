//
//  AccountSettingsModels.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

enum AccountSettingsItem {
    case optionalExpenses
    case requiredExpenses

    var title: String {
        switch self {
        case .optionalExpenses:
            return "account_settings_optional_expenses_title".localized
        case .requiredExpenses:
            return "account_settings_required_expenses_title".localized
        }
    }

    var subtitle: String? {
        switch self {
        case .optionalExpenses:
            return "account_settings_optional_expenses_description".localized
        case .requiredExpenses:
            return "account_settings_required_expenses_description".localized
        }
    }
}
