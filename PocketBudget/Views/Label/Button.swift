//
//  Button.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import ExtendedFoundations
import UIKit

class Button: UILocalizableButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        titleLabel?.font = AppFont.font(basedOn: titleLabel?.font)
    }
}
