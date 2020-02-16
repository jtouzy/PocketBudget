//
//  UIFontTextStyle+extensions.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

extension UIFont.TextStyle {
    var sizeForStyle: CGFloat {
        switch self {
        case .title1:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .body, .headline:
            return 17
        case .subheadline:
            return 15
        case .footnote:
            return 13
        case .caption1:
            return 12
        case .caption2:
            return 11
        default:
            return 0
        }
    }
}
