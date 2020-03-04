//
//  MonthBalanceCell.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 02/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

class MonthBalanceCell: UITableViewCell {
    @IBOutlet weak var wrapperView: UIView! {
        didSet {
            wrapperView.layer.cornerRadius = 10
            wrapperView.layer.shadowColor = UIColor.gray.cgColor
            wrapperView.layer.shadowOpacity = 0.5
            wrapperView.layer.shadowRadius = 5
            wrapperView.layer.shadowOffset = .zero
        }
    }
    @IBOutlet weak var expenseTitleLabel: UILabel!

    func configure(transaction: Transaction) {
        expenseTitleLabel.text = transaction.title
    }
}
