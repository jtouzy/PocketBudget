//
//  CGRect+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 02/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

public extension CGRect {
    func updated(x: CGFloat? = nil, y: CGFloat? = nil,
                 width: CGFloat? = nil, height: CGFloat? = nil) -> CGRect {
        return CGRect(
            x: x ?? maxX,
            y: y ?? minY,
            width: width ?? self.width,
            height: height ?? self.height
        )
    }
}
