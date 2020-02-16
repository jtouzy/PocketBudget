//
//  AccountSettingsModels.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

enum AccountSettingsItem {
    case requiredExpenses

    var title: String {
        switch self {
        case .requiredExpenses:
            return "account_settings_required_expenses_title".localized
        }
    }

    var subtitle: String? {
        switch self {
        case .requiredExpenses:
            return "account_settings_required_expenses_description".localized
        }
    }
}
