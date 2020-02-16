//
//  UILocalizableLabel.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

open class UILocalizableLabel: UILabel {
    @IBInspectable var localizedKey: String? {
        didSet {
            text = localizedKey?.localized
        }
    }
}
