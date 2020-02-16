//
//  UILocalizableButton.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

public class UILocalizableButton: UIButton {
    @IBInspectable var localizedKey: String? {
        didSet {
            setTitle(localizedKey?.localized, for: .normal)
        }
    }
}
