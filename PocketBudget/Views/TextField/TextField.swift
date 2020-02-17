//
//  TextField.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 17/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import MaterialTextField

class TextField: MFTextField {
    @IBInspectable var placeholderLocalizedKey: String? {
        didSet {
            placeholder = placeholderLocalizedKey?.localized
        }
    }
}
