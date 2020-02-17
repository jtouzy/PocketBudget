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

//
// MARK: Material colors.
// From: https://material.io/resources/color, variant 600
//
extension UIColor {
    static var materialColors: [UIColor] = [
        .materialRed,
        .materialPink,
        .materialPurple,
        .materialDeepPurple,
        .materialIndigo,
        .materialBlue,
        .materialLightBlue,
        .materialCyan,
        .materialTeal,
        .materialGreen,
        .materialLightGreen,
        .materialLime,
        .materialYellow,
        .materialAmber,
        .materialOrange,
        .materialDeepOrange,
        .materialBrown,
        .materialGrey,
        .materialBlueGrey
    ]
    static var materialRed: UIColor { UIColor(named: "MaterialRed") ?? .clear }
    static var materialPink: UIColor { UIColor(named: "MaterialPink") ?? .clear }
    static var materialPurple: UIColor { UIColor(named: "MaterialPurple") ?? .clear }
    static var materialDeepPurple: UIColor { UIColor(named: "MaterialDeepPurple") ?? .clear }
    static var materialIndigo: UIColor { UIColor(named: "MaterialIndigo") ?? .clear }
    static var materialBlue: UIColor { UIColor(named: "MaterialBlue") ?? .clear }
    static var materialLightBlue: UIColor { UIColor(named: "MaterialLightBlue") ?? .clear }
    static var materialCyan: UIColor { UIColor(named: "MaterialCyan") ?? .clear }
    static var materialTeal: UIColor { UIColor(named: "MaterialTeal") ?? .clear }
    static var materialGreen: UIColor { UIColor(named: "MaterialGreen") ?? .clear }
    static var materialLightGreen: UIColor { UIColor(named: "MaterialLightGreen") ?? .clear }
    static var materialLime: UIColor { UIColor(named: "MaterialLime") ?? .clear }
    static var materialYellow: UIColor { UIColor(named: "MaterialYellow") ?? .clear }
    static var materialAmber: UIColor { UIColor(named: "MaterialAmber") ?? .clear }
    static var materialOrange: UIColor { UIColor(named: "MaterialOrange") ?? .clear }
    static var materialDeepOrange: UIColor { UIColor(named: "MaterialDeepOrange") ?? .clear }
    static var materialBrown: UIColor { UIColor(named: "MaterialBrown") ?? .clear }
    static var materialGrey: UIColor { UIColor(named: "MaterialGrey") ?? .clear }
    static var materialBlueGrey: UIColor { UIColor(named: "MaterialBlueGrey") ?? .clear }
}
