//
//  EmptyView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import UIKit

class EmptyView: UIView {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    var actionButtonSignal: Signal<()> {
        return actionButton.rx.tap.asSignal()
    }

    func configure(with title: String) -> EmptyView {
        messageLabel.text = title
        return self
    }
}
