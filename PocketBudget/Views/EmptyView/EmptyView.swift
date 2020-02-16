//
//  EmptyView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import UIKit

typealias EmptyViewModel = (title: String, actionTitle: String?)

class EmptyView: UIView {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.isHidden = false
        }
    }

    var actionButtonSignal: Signal<()> {
        return actionButton.rx.tap.asSignal()
    }

    @discardableResult
    func configure(with model: EmptyViewModel) -> EmptyView {
        messageLabel.text = model.title
        if let actionTitle = model.actionTitle {
            actionButton.setTitle(actionTitle, for: .normal)
        } else {
            actionButton.isHidden = true
        }
        return self
    }
}
