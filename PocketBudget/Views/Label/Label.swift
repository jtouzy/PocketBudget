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

    init(frame: CGRect, font: UIFont? = nil) {
        super.init(frame: frame)
        self.font = font ?? AppFont.font(basedOn: self.font)
    }
}
