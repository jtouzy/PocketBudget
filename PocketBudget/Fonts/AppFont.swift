//
//  AppFont.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

class AppFont {
    static func font(basedOn font: UIFont? = nil) -> UIFont? {
        guard
            let baseFont = font,
            let textStyle = baseFont.fontDescriptor.object(
                forKey: UIFontDescriptor.AttributeName.textStyle
            ) as? UIFont.TextStyle
        else {
            return nil
        }
        return AppFont.font(fromStyle: textStyle)
    }

    static func font(fromStyle textStyle: UIFont.TextStyle) -> UIFont? {
        guard let appFont = UIFont(name: "Lato-Regular", size: textStyle.sizeForStyle) else {
            return nil
        }
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: appFont)
    }
}
