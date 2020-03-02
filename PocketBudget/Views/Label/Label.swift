//
//  Label.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import ExtendedFoundations
import UIKit

import UIKit

class Label: UILocalizableLabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        font = AppFont.font(basedOn: font)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        font = AppFont.font(basedOn: font)
    }
}
