//
//  UIColor+extensions.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 17/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

extension UIColor {
    var asColor: Color {
        let ciColor = CIColor(color: self)
        return Color(red: ciColor.red, green: ciColor.green, blue: ciColor.blue)
    }

    static func fromColor(_ color: Color) -> UIColor {
        return UIColor(red: color.red, green: color.green, blue: color.blue, alpha: 1)
    }
}
