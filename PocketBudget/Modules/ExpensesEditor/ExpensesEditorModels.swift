//
//  ExpensesEditorModels.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 18/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

class ExpenseUI {
    let id: String
    let title: String
    let amount: String
    let color: UIColor

    init(id: String, title: String, amount: String, color: UIColor) {
        self.id = id
        self.title = title
        self.amount = amount
        self.color = color
    }
}
